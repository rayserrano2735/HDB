-- Healthcare Claims Reporting Views
-- Common reports for claims processing companies

USE SCHEMA healthcare;

-- 1. Claims Summary Dashboard View
CREATE OR REPLACE VIEW v_claims_summary_dashboard AS
SELECT 
    DATE_TRUNC('month', c.submission_date) as month,
    c.claim_status,
    c.claim_type,
    COUNT(DISTINCT c.claim_id) as claim_count,
    SUM(c.total_charge_amount) as total_charges,
    SUM(c.total_allowed_amount) as total_allowed,
    SUM(c.total_paid_amount) as total_paid,
    SUM(c.patient_responsibility) as total_patient_resp,
    AVG(DATEDIFF('day', c.submission_date, p.payment_date)) as avg_days_to_payment,
    SUM(c.total_charge_amount) - SUM(c.total_paid_amount) as total_write_off
FROM claim c
LEFT JOIN payment p ON c.claim_id = p.claim_id
GROUP BY 1, 2, 3;

-- 2. Denial Analysis View
CREATE OR REPLACE VIEW v_denial_analysis AS
SELECT 
    d.denial_category,
    d.denial_code,
    d.denial_reason,
    COUNT(DISTINCT d.claim_id) as denial_count,
    SUM(c.total_charge_amount) as denied_charges,
    SUM(c.total_allowed_amount) as denied_allowed,
    COUNT(DISTINCT a.appeal_id) as appeals_filed,
    COUNT(DISTINCT CASE WHEN a.appeal_status = 'Approved' THEN a.appeal_id END) as appeals_won,
    SUM(a.appeal_outcome_amount) as amount_recovered,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN a.appeal_status = 'Approved' THEN a.appeal_id END) / 
          NULLIF(COUNT(DISTINCT a.appeal_id), 0), 2) as appeal_win_rate_pct
FROM denial d
JOIN claim c ON d.claim_id = c.claim_id
LEFT JOIN appeal a ON d.denial_id = a.denial_id
GROUP BY 1, 2, 3;

-- 3. Provider Performance View
CREATE OR REPLACE VIEW v_provider_performance AS
SELECT 
    pr.provider_id,
    pr.npi,
    pr.first_name || ' ' || pr.last_name as provider_name,
    pr.specialty,
    COUNT(DISTINCT c.claim_id) as total_claims,
    COUNT(DISTINCT c.patient_id) as unique_patients,
    SUM(c.total_charge_amount) as total_billed,
    SUM(c.total_paid_amount) as total_reimbursed,
    AVG(c.total_paid_amount / NULLIF(c.total_charge_amount, 0)) * 100 as avg_reimbursement_rate,
    COUNT(DISTINCT CASE WHEN c.claim_status = 'Denied' THEN c.claim_id END) as denied_claims,
    COUNT(DISTINCT CASE WHEN c.claim_status = 'Denied' THEN c.claim_id END) * 100.0 / 
        NULLIF(COUNT(DISTINCT c.claim_id), 0) as denial_rate_pct,
    AVG(DATEDIFF('day', c.submission_date, c.created_date)) as avg_submission_lag_days
FROM provider pr
LEFT JOIN claim c ON pr.provider_id IN (c.billing_provider_id, c.rendering_provider_id)
GROUP BY 1, 2, 3, 4;

-- 4. Payer Performance View
CREATE OR REPLACE VIEW v_payer_performance AS
SELECT 
    ip.payer_id,
    ip.payer_name,
    ip.plan_type,
    COUNT(DISTINCT c.claim_id) as claim_count,
    SUM(c.total_charge_amount) as total_charges,
    SUM(c.total_paid_amount) as total_paid,
    AVG(c.total_paid_amount / NULLIF(c.total_allowed_amount, 0)) * 100 as payment_to_allowed_ratio,
    COUNT(DISTINCT CASE WHEN c.claim_status = 'Denied' THEN c.claim_id END) as denied_claims,
    AVG(DATEDIFF('day', c.submission_date, p.payment_date)) as avg_payment_days,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY DATEDIFF('day', c.submission_date, p.payment_date)) as median_payment_days,
    COUNT(DISTINCT d.denial_id) as total_denials,
    COUNT(DISTINCT a.appeal_id) as total_appeals
FROM insurance_plan ip
JOIN claim c ON ip.plan_id = c.plan_id
LEFT JOIN payment p ON c.claim_id = p.claim_id
LEFT JOIN denial d ON c.claim_id = d.claim_id
LEFT JOIN appeal a ON d.denial_id = a.denial_id
GROUP BY 1, 2, 3;

-- 5. Revenue Cycle KPIs View
CREATE OR REPLACE VIEW v_revenue_cycle_kpis AS
WITH monthly_metrics AS (
    SELECT 
        DATE_TRUNC('month', c.submission_date) as month,
        SUM(c.total_charge_amount) as gross_charges,
        SUM(c.total_paid_amount) as net_revenue,
        SUM(CASE WHEN c.claim_status = 'Denied' THEN c.total_charge_amount ELSE 0 END) as denied_charges,
        COUNT(DISTINCT c.claim_id) as claim_volume,
        COUNT(DISTINCT CASE WHEN c.claim_status = 'Denied' THEN c.claim_id END) as denied_claims,
        AVG(DATEDIFF('day', c.submission_date, p.payment_date)) as days_in_ar
    FROM claim c
    LEFT JOIN payment p ON c.claim_id = p.claim_id
    GROUP BY 1
)
SELECT 
    month,
    gross_charges,
    net_revenue,
    denied_charges,
    claim_volume,
    ROUND(net_revenue / NULLIF(gross_charges, 0) * 100, 2) as net_collection_rate,
    ROUND(denied_claims * 100.0 / NULLIF(claim_volume, 0), 2) as denial_rate,
    ROUND(denied_charges / NULLIF(gross_charges, 0) * 100, 2) as denial_write_off_rate,
    days_in_ar,
    gross_charges / NULLIF(days_in_ar, 0) as ar_turnover_rate
FROM monthly_metrics;

-- 6. Patient Financial Responsibility View
CREATE OR REPLACE VIEW v_patient_financial_responsibility AS
SELECT 
    c.patient_id,
    pt.first_name || ' ' || pt.last_name as patient_name,
    COUNT(DISTINCT c.claim_id) as claim_count,
    SUM(c.patient_responsibility) as total_responsibility,
    SUM(c.deductible_amount) as total_deductible,
    SUM(c.copay_amount) as total_copay,
    SUM(c.coinsurance_amount) as total_coinsurance,
    AVG(c.patient_responsibility) as avg_responsibility_per_claim,
    MAX(c.patient_responsibility) as max_single_claim_responsibility,
    COUNT(DISTINCT CASE WHEN c.patient_responsibility > 1000 THEN c.claim_id END) as high_balance_claims
FROM claim c
JOIN patient pt ON c.patient_id = pt.patient_id
GROUP BY 1, 2
HAVING SUM(c.patient_responsibility) > 0;

-- 7. Prior Authorization Effectiveness View
CREATE OR REPLACE VIEW v_prior_auth_effectiveness AS
SELECT 
    pa.auth_status,
    pa.procedure_code,
    COUNT(DISTINCT pa.auth_id) as auth_count,
    COUNT(DISTINCT c.claim_id) as claims_with_auth,
    COUNT(DISTINCT CASE WHEN c.claim_status = 'Approved' THEN c.claim_id END) as approved_claims,
    COUNT(DISTINCT CASE WHEN c.claim_status = 'Denied' THEN c.claim_id END) as denied_claims,
    AVG(DATEDIFF('day', pa.created_date, c.submission_date)) as avg_days_auth_to_claim,
    SUM(c.total_paid_amount) as total_paid_with_auth,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN c.claim_status = 'Approved' THEN c.claim_id END) / 
          NULLIF(COUNT(DISTINCT c.claim_id), 0), 2) as approval_rate_with_auth
FROM prior_authorization pa
LEFT JOIN claim c ON pa.auth_id = c.auth_id
GROUP BY 1, 2;

-- 8. Facility Utilization View
CREATE OR REPLACE VIEW v_facility_utilization AS
SELECT 
    f.facility_id,
    f.facility_name,
    f.facility_type,
    COUNT(DISTINCT e.encounter_id) as total_encounters,
    COUNT(DISTINCT e.patient_id) as unique_patients,
    COUNT(DISTINCT CASE WHEN e.encounter_type = 'Inpatient' THEN e.encounter_id END) as inpatient_encounters,
    COUNT(DISTINCT CASE WHEN e.encounter_type = 'Outpatient' THEN e.encounter_id END) as outpatient_encounters,
    COUNT(DISTINCT CASE WHEN e.encounter_type = 'Emergency' THEN e.encounter_id END) as emergency_encounters,
    AVG(DATEDIFF('day', e.admission_date, e.discharge_date)) as avg_length_of_stay,
    COUNT(DISTINCT c.claim_id) as total_claims,
    SUM(c.total_charge_amount) as total_charges,
    SUM(c.total_paid_amount) as total_reimbursement
FROM facility f
LEFT JOIN encounter e ON f.facility_id = e.facility_id
LEFT JOIN claim c ON e.encounter_id = c.encounter_id
GROUP BY 1, 2, 3;

-- 9. Diagnosis Frequency and Cost View
CREATE OR REPLACE VIEW v_diagnosis_analysis AS
SELECT 
    d.diagnosis_code,
    d.diagnosis_description,
    COUNT(DISTINCT d.encounter_id) as encounter_count,
    COUNT(DISTINCT e.patient_id) as patient_count,
    COUNT(DISTINCT c.claim_id) as claim_count,
    SUM(c.total_charge_amount) as total_charges,
    SUM(c.total_paid_amount) as total_paid,
    AVG(c.total_charge_amount) as avg_charge_per_claim,
    AVG(c.total_paid_amount) as avg_payment_per_claim,
    COUNT(DISTINCT CASE WHEN d.diagnosis_rank = 1 THEN d.encounter_id END) as primary_diagnosis_count
FROM diagnosis d
JOIN encounter e ON d.encounter_id = e.encounter_id
LEFT JOIN claim c ON e.encounter_id = c.encounter_id
GROUP BY 1, 2
ORDER BY encounter_count DESC;

-- 10. Claims Aging View
CREATE OR REPLACE VIEW v_claims_aging AS
WITH aging_buckets AS (
    SELECT 
        c.claim_id,
        c.claim_number,
        c.patient_id,
        c.claim_status,
        c.total_charge_amount,
        c.total_paid_amount,
        c.submission_date,
        CURRENT_DATE() - c.submission_date::DATE as days_outstanding,
        CASE 
            WHEN CURRENT_DATE() - c.submission_date::DATE <= 30 THEN '0-30 days'
            WHEN CURRENT_DATE() - c.submission_date::DATE <= 60 THEN '31-60 days'
            WHEN CURRENT_DATE() - c.submission_date::DATE <= 90 THEN '61-90 days'
            WHEN CURRENT_DATE() - c.submission_date::DATE <= 120 THEN '91-120 days'
            ELSE '120+ days'
        END as aging_bucket
    FROM claim c
    WHERE c.claim_status IN ('Pending', 'Denied')
)
SELECT 
    aging_bucket,
    COUNT(DISTINCT claim_id) as claim_count,
    SUM(total_charge_amount) as total_charges,
    SUM(total_charge_amount - total_paid_amount) as outstanding_amount,
    AVG(days_outstanding) as avg_days_outstanding,
    MIN(submission_date) as oldest_claim_date
FROM aging_buckets
GROUP BY 1
ORDER BY 
    CASE aging_bucket
        WHEN '0-30 days' THEN 1
        WHEN '31-60 days' THEN 2
        WHEN '61-90 days' THEN 3
        WHEN '91-120 days' THEN 4
        ELSE 5
    END;

-- 11. Appeal Success Rate by Category View
CREATE OR REPLACE VIEW v_appeal_success_analysis AS
SELECT 
    d.denial_category,
    d.denial_reason,
    a.appeal_level,
    COUNT(DISTINCT a.appeal_id) as total_appeals,
    COUNT(DISTINCT CASE WHEN a.appeal_status = 'Approved' THEN a.appeal_id END) as successful_appeals,
    COUNT(DISTINCT CASE WHEN a.appeal_status = 'Denied' THEN a.appeal_id END) as failed_appeals,
    COUNT(DISTINCT CASE WHEN a.appeal_status = 'Pending' THEN a.appeal_id END) as pending_appeals,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN a.appeal_status = 'Approved' THEN a.appeal_id END) / 
          NULLIF(COUNT(DISTINCT a.appeal_id), 0), 2) as success_rate_pct,
    SUM(a.appeal_outcome_amount) as total_recovered,
    AVG(a.appeal_outcome_amount) as avg_recovery_amount,
    AVG(DATEDIFF('day', a.appeal_date, a.appeal_decision_date)) as avg_decision_days
FROM denial d
JOIN appeal a ON d.denial_id = a.denial_id
GROUP BY 1, 2, 3;

-- 12. Procedure Profitability View
CREATE OR REPLACE VIEW v_procedure_profitability AS
SELECT 
    pr.procedure_code,
    pr.procedure_description,
    COUNT(DISTINCT pr.procedure_id) as procedure_count,
    COUNT(DISTINCT cli.claim_id) as claim_count,
    SUM(cli.charge_amount) as total_charges,
    SUM(cli.allowed_amount) as total_allowed,
    SUM(cli.paid_amount) as total_paid,
    AVG(cli.paid_amount / NULLIF(cli.charge_amount, 0)) * 100 as avg_reimbursement_rate,
    SUM(cli.charge_amount - cli.paid_amount) as total_adjustment,
    COUNT(DISTINCT CASE WHEN d.denial_id IS NOT NULL THEN cli.claim_id END) as denied_count
FROM procedure pr
JOIN claim_line_item cli ON pr.procedure_code = cli.procedure_code
LEFT JOIN denial d ON cli.claim_id = d.claim_id AND cli.line_item_id = d.line_item_id
GROUP BY 1, 2
ORDER BY total_charges DESC;

-- 13. Coordination of Benefits Summary View
CREATE OR REPLACE VIEW v_cob_summary AS
SELECT 
    cob.patient_id,
    pt.first_name || ' ' || pt.last_name as patient_name,
    ip1.payer_name as primary_payer,
    ip2.payer_name as secondary_payer,
    COUNT(DISTINCT cob.claim_id) as cob_claim_count,
    SUM(c.total_charge_amount) as total_charges,
    SUM(cob.primary_paid_amount) as primary_payments,
    SUM(cob.secondary_paid_amount) as secondary_payments,
    SUM(cob.patient_paid_amount) as patient_payments,
    SUM(cob.primary_paid_amount + cob.secondary_paid_amount) as total_insurance_payments,
    ROUND(100.0 * SUM(cob.primary_paid_amount + cob.secondary_paid_amount) / 
          NULLIF(SUM(c.total_charge_amount), 0), 2) as combined_payment_rate
FROM coordination_of_benefits cob
JOIN patient pt ON cob.patient_id = pt.patient_id
JOIN insurance_plan ip1 ON cob.primary_plan_id = ip1.plan_id
JOIN insurance_plan ip2 ON cob.secondary_plan_id = ip2.plan_id
JOIN claim c ON cob.claim_id = c.claim_id
GROUP BY 1, 2, 3, 4;

-- 14. Monthly Trend Analysis View
CREATE OR REPLACE VIEW v_monthly_trends AS
SELECT 
    DATE_TRUNC('month', c.submission_date) as month,
    COUNT(DISTINCT c.claim_id) as total_claims,
    COUNT(DISTINCT c.patient_id) as unique_patients,
    COUNT(DISTINCT e.encounter_id) as total_encounters,
    SUM(c.total_charge_amount) as total_charges,
    SUM(c.total_allowed_amount) as total_allowed,
    SUM(c.total_paid_amount) as total_paid,
    AVG(c.total_charge_amount) as avg_claim_amount,
    COUNT(DISTINCT CASE WHEN c.claim_status = 'Approved' THEN c.claim_id END) as approved_claims,
    COUNT(DISTINCT CASE WHEN c.claim_status = 'Denied' THEN c.claim_id END) as denied_claims,
    COUNT(DISTINCT CASE WHEN c.claim_status = 'Pending' THEN c.claim_id END) as pending_claims,
    ROUND(100.0 * COUNT(DISTINCT CASE WHEN c.claim_status = 'Denied' THEN c.claim_id END) / 
          NULLIF(COUNT(DISTINCT c.claim_id), 0), 2) as denial_rate,
    LAG(SUM(c.total_charge_amount), 1) OVER (ORDER BY DATE_TRUNC('month', c.submission_date)) as prev_month_charges,
    ROUND(100.0 * (SUM(c.total_charge_amount) - LAG(SUM(c.total_charge_amount), 1) 
          OVER (ORDER BY DATE_TRUNC('month', c.submission_date))) / 
          NULLIF(LAG(SUM(c.total_charge_amount), 1) OVER (ORDER BY DATE_TRUNC('month', c.submission_date)), 0), 2) as month_over_month_growth
FROM claim c
LEFT JOIN encounter e ON c.encounter_id = e.encounter_id
GROUP BY 1
ORDER BY 1 DESC;

-- 15. Real-time Claims Processing Status View
CREATE OR REPLACE VIEW v_claims_processing_status AS
SELECT 
    c.claim_status,
    COUNT(DISTINCT c.claim_id) as claim_count,
    SUM(c.total_charge_amount) as total_charges,
    AVG(CURRENT_DATE() - c.submission_date::DATE) as avg_age_days,
    MIN(c.submission_date) as oldest_claim_date,
    MAX(c.submission_date) as newest_claim_date,
    COUNT(DISTINCT CASE WHEN CURRENT_DATE() - c.submission_date::DATE > 30 THEN c.claim_id END) as aged_over_30_days,
    COUNT(DISTINCT CASE WHEN CURRENT_DATE() - c.submission_date::DATE > 60 THEN c.claim_id END) as aged_over_60_days,
    COUNT(DISTINCT CASE WHEN CURRENT_DATE() - c.submission_date::DATE > 90 THEN c.claim_id END) as aged_over_90_days
FROM claim c
GROUP BY 1;

-- Grant permissions (adjust as needed)
GRANT SELECT ON ALL VIEWS IN SCHEMA healthcare TO ROLE analyst_role;
GRANT SELECT ON ALL VIEWS IN SCHEMA healthcare TO ROLE reporting_role;