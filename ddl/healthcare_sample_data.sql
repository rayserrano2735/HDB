-- Healthcare Claims Sample Data
-- 100 claims with all related records properly joined
-- Use this script after creating the database schema

USE SCHEMA healthcare;

-- Clear existing data (optional - remove if appending)
TRUNCATE TABLE coordination_of_benefits;
TRUNCATE TABLE fee_schedule;
TRUNCATE TABLE appeal;
TRUNCATE TABLE denial;
TRUNCATE TABLE payment_adjustment;
TRUNCATE TABLE payment;
TRUNCATE TABLE claim_line_item;
TRUNCATE TABLE claim;
TRUNCATE TABLE prior_authorization;
TRUNCATE TABLE procedure;
TRUNCATE TABLE diagnosis;
TRUNCATE TABLE encounter;
TRUNCATE TABLE patient_insurance;
TRUNCATE TABLE insurance_plan;
TRUNCATE TABLE facility;
TRUNCATE TABLE provider;
TRUNCATE TABLE patient;

-- Insert Patients (20 patients for 100 claims)
INSERT INTO patient (patient_id, medical_record_number, first_name, last_name, date_of_birth, gender, ssn, address_line1, city, state, zip_code, phone_number, email) VALUES
('PAT001', 'MRN001', 'John', 'Smith', '1975-03-15', 'M', '123-45-6789', '123 Main St', 'Denver', 'CO', '80201', '303-555-0101', 'john.smith@email.com'),
('PAT002', 'MRN002', 'Mary', 'Johnson', '1982-07-22', 'F', '234-56-7890', '456 Oak Ave', 'Boulder', 'CO', '80301', '303-555-0102', 'mary.johnson@email.com'),
('PAT003', 'MRN003', 'Robert', 'Williams', '1968-11-30', 'M', '345-67-8901', '789 Pine Rd', 'Aurora', 'CO', '80010', '303-555-0103', 'robert.williams@email.com'),
('PAT004', 'MRN004', 'Patricia', 'Brown', '1990-01-18', 'F', '456-78-9012', '321 Elm St', 'Littleton', 'CO', '80120', '303-555-0104', 'patricia.brown@email.com'),
('PAT005', 'MRN005', 'Michael', 'Davis', '1955-09-05', 'M', '567-89-0123', '654 Maple Dr', 'Westminster', 'CO', '80030', '303-555-0105', 'michael.davis@email.com'),
('PAT006', 'MRN006', 'Linda', 'Miller', '1978-04-12', 'F', '678-90-1234', '987 Cedar Ln', 'Arvada', 'CO', '80002', '303-555-0106', 'linda.miller@email.com'),
('PAT007', 'MRN007', 'David', 'Wilson', '1985-12-25', 'M', '789-01-2345', '147 Birch St', 'Lakewood', 'CO', '80214', '303-555-0107', 'david.wilson@email.com'),
('PAT008', 'MRN008', 'Jennifer', 'Moore', '1972-06-08', 'F', '890-12-3456', '258 Spruce Ave', 'Parker', 'CO', '80134', '303-555-0108', 'jennifer.moore@email.com'),
('PAT009', 'MRN009', 'James', 'Taylor', '1964-02-14', 'M', '901-23-4567', '369 Ash Rd', 'Castle Rock', 'CO', '80109', '303-555-0109', 'james.taylor@email.com'),
('PAT010', 'MRN010', 'Barbara', 'Anderson', '1988-10-20', 'F', '012-34-5678', '741 Willow Way', 'Centennial', 'CO', '80111', '303-555-0110', 'barbara.anderson@email.com'),
('PAT011', 'MRN011', 'William', 'Thomas', '1970-05-16', 'M', '123-45-6780', '852 Palm Dr', 'Highlands Ranch', 'CO', '80129', '303-555-0111', 'william.thomas@email.com'),
('PAT012', 'MRN012', 'Susan', 'Jackson', '1983-08-27', 'F', '234-56-7891', '963 Cypress St', 'Englewood', 'CO', '80110', '303-555-0112', 'susan.jackson@email.com'),
('PAT013', 'MRN013', 'Charles', 'White', '1959-03-03', 'M', '345-67-8902', '159 Magnolia Ave', 'Greenwood Village', 'CO', '80121', '303-555-0113', 'charles.white@email.com'),
('PAT014', 'MRN014', 'Jessica', 'Harris', '1992-11-11', 'F', '456-78-9013', '753 Sycamore Ln', 'Lone Tree', 'CO', '80124', '303-555-0114', 'jessica.harris@email.com'),
('PAT015', 'MRN015', 'Thomas', 'Martin', '1967-07-07', 'M', '567-89-0124', '357 Dogwood Dr', 'Broomfield', 'CO', '80020', '303-555-0115', 'thomas.martin@email.com'),
('PAT016', 'MRN016', 'Sarah', 'Thompson', '1979-09-19', 'F', '678-90-1235', '468 Hawthorn St', 'Thornton', 'CO', '80229', '303-555-0116', 'sarah.thompson@email.com'),
('PAT017', 'MRN017', 'Christopher', 'Garcia', '1986-01-26', 'M', '789-01-2346', '579 Juniper Ave', 'Northglenn', 'CO', '80233', '303-555-0117', 'christopher.garcia@email.com'),
('PAT018', 'MRN018', 'Karen', 'Martinez', '1974-04-30', 'F', '890-12-3457', '681 Hickory Rd', 'Commerce City', 'CO', '80022', '303-555-0118', 'karen.martinez@email.com'),
('PAT019', 'MRN019', 'Daniel', 'Robinson', '1961-12-15', 'M', '901-23-4568', '792 Walnut Way', 'Brighton', 'CO', '80601', '303-555-0119', 'daniel.robinson@email.com'),
('PAT020', 'MRN020', 'Nancy', 'Clark', '1987-06-23', 'F', '012-34-5679', '246 Chestnut Ln', 'Federal Heights', 'CO', '80260', '303-555-0120', 'nancy.clark@email.com');

-- Insert Providers (10 providers)
INSERT INTO provider (provider_id, npi, provider_type, first_name, last_name, specialty, tax_id, address_line1, city, state, zip_code, phone_number) VALUES
('PROV001', '1234567890', 'Physician', 'Dr. Amanda', 'Chen', 'Internal Medicine', '98-7654321', '100 Medical Plaza', 'Denver', 'CO', '80202', '303-555-1001'),
('PROV002', '2345678901', 'Physician', 'Dr. Brian', 'Patel', 'Cardiology', '87-6543210', '200 Heart Center Dr', 'Aurora', 'CO', '80011', '303-555-1002'),
('PROV003', '3456789012', 'Physician', 'Dr. Carol', 'Rodriguez', 'Orthopedics', '76-5432109', '300 Bone & Joint Way', 'Littleton', 'CO', '80121', '303-555-1003'),
('PROV004', '4567890123', 'Physician', 'Dr. David', 'Kim', 'Emergency Medicine', '65-4321098', '400 ER Boulevard', 'Denver', 'CO', '80203', '303-555-1004'),
('PROV005', '5678901234', 'Physician', 'Dr. Emily', 'Johnson', 'Radiology', '54-3210987', '500 Imaging Center', 'Boulder', 'CO', '80302', '303-555-1005'),
('PROV006', '6789012345', 'Physician', 'Dr. Frank', 'Liu', 'Surgery', '43-2109876', '600 Surgical Tower', 'Denver', 'CO', '80204', '303-555-1006'),
('PROV007', '7890123456', 'Nurse Practitioner', 'Sarah', 'Williams', 'Family Practice', '32-1098765', '700 Family Care Ln', 'Westminster', 'CO', '80031', '303-555-1007'),
('PROV008', '8901234567', 'Physician', 'Dr. George', 'Brown', 'Pediatrics', '21-0987654', '800 Children Way', 'Aurora', 'CO', '80012', '303-555-1008'),
('PROV009', '9012345678', 'Physician Assistant', 'Michael', 'Davis', 'Urgent Care', '10-9876543', '900 Quick Care Rd', 'Lakewood', 'CO', '80215', '303-555-1009'),
('PROV010', '0123456789', 'Physician', 'Dr. Helen', 'Taylor', 'Oncology', '09-8765432', '1000 Cancer Center', 'Denver', 'CO', '80205', '303-555-1010');

-- Insert Facilities (5 facilities)
INSERT INTO facility (facility_id, facility_name, facility_type, npi, tax_id, address_line1, city, state, zip_code, phone_number) VALUES
('FAC001', 'Denver General Hospital', 'Hospital', '1122334455', '11-2233445', '1001 Hospital Way', 'Denver', 'CO', '80206', '303-555-2001'),
('FAC002', 'Aurora Medical Center', 'Hospital', '2233445566', '22-3344556', '2002 Medical Center Dr', 'Aurora', 'CO', '80013', '303-555-2002'),
('FAC003', 'Boulder Community Clinic', 'Clinic', '3344556677', '33-4455667', '3003 Community Health Rd', 'Boulder', 'CO', '80303', '303-555-2003'),
('FAC004', 'Littleton Surgery Center', 'ASC', '4455667788', '44-5566778', '4004 Surgery Plaza', 'Littleton', 'CO', '80122', '303-555-2004'),
('FAC005', 'Westminster Urgent Care', 'Urgent Care', '5566778899', '55-6677889', '5005 Urgent Lane', 'Westminster', 'CO', '80032', '303-555-2005');

-- Insert Insurance Plans (5 plans)
INSERT INTO insurance_plan (plan_id, payer_id, payer_name, plan_name, plan_type, group_number) VALUES
('PLAN001', 'PAY001', 'Blue Cross Blue Shield', 'BCBS PPO Gold', 'PPO', 'GRP1001'),
('PLAN002', 'PAY002', 'United Healthcare', 'UHC HMO Silver', 'HMO', 'GRP2002'),
('PLAN003', 'PAY003', 'Aetna', 'Aetna Choice POS', 'POS', 'GRP3003'),
('PLAN004', 'PAY004', 'Cigna', 'Cigna Open Access', 'PPO', 'GRP4004'),
('PLAN005', 'PAY005', 'Kaiser Permanente', 'Kaiser HMO Bronze', 'HMO', 'GRP5005');

-- Insert Patient Insurance (all patients have coverage)
INSERT INTO patient_insurance (coverage_id, patient_id, plan_id, member_id, coverage_type, effective_date, termination_date, copay_amount, deductible_amount, out_of_pocket_max) VALUES
('COV001', 'PAT001', 'PLAN001', 'BCBS001234', 'Primary', '2024-01-01', '2025-12-31', 25.00, 1000.00, 5000.00),
('COV002', 'PAT002', 'PLAN002', 'UHC002345', 'Primary', '2024-01-01', '2025-12-31', 20.00, 1500.00, 6000.00),
('COV003', 'PAT003', 'PLAN003', 'AET003456', 'Primary', '2024-01-01', '2025-12-31', 30.00, 2000.00, 7000.00),
('COV004', 'PAT004', 'PLAN004', 'CIG004567', 'Primary', '2024-01-01', '2025-12-31', 35.00, 1200.00, 5500.00),
('COV005', 'PAT005', 'PLAN005', 'KP005678', 'Primary', '2024-01-01', '2025-12-31', 15.00, 500.00, 3000.00),
('COV006', 'PAT006', 'PLAN001', 'BCBS006789', 'Primary', '2024-01-01', '2025-12-31', 25.00, 1000.00, 5000.00),
('COV007', 'PAT007', 'PLAN002', 'UHC007890', 'Primary', '2024-01-01', '2025-12-31', 20.00, 1500.00, 6000.00),
('COV008', 'PAT008', 'PLAN003', 'AET008901', 'Primary', '2024-01-01', '2025-12-31', 30.00, 2000.00, 7000.00),
('COV009', 'PAT009', 'PLAN004', 'CIG009012', 'Primary', '2024-01-01', '2025-12-31', 35.00, 1200.00, 5500.00),
('COV010', 'PAT010', 'PLAN005', 'KP010123', 'Primary', '2024-01-01', '2025-12-31', 15.00, 500.00, 3000.00),
('COV011', 'PAT011', 'PLAN001', 'BCBS011234', 'Primary', '2024-01-01', '2025-12-31', 25.00, 1000.00, 5000.00),
('COV012', 'PAT012', 'PLAN002', 'UHC012345', 'Primary', '2024-01-01', '2025-12-31', 20.00, 1500.00, 6000.00),
('COV013', 'PAT013', 'PLAN003', 'AET013456', 'Primary', '2024-01-01', '2025-12-31', 30.00, 2000.00, 7000.00),
('COV014', 'PAT014', 'PLAN004', 'CIG014567', 'Primary', '2024-01-01', '2025-12-31', 35.00, 1200.00, 5500.00),
('COV015', 'PAT015', 'PLAN005', 'KP015678', 'Primary', '2024-01-01', '2025-12-31', 15.00, 500.00, 3000.00),
('COV016', 'PAT016', 'PLAN001', 'BCBS016789', 'Primary', '2024-01-01', '2025-12-31', 25.00, 1000.00, 5000.00),
('COV017', 'PAT017', 'PLAN002', 'UHC017890', 'Primary', '2024-01-01', '2025-12-31', 20.00, 1500.00, 6000.00),
('COV018', 'PAT018', 'PLAN003', 'AET018901', 'Primary', '2024-01-01', '2025-12-31', 30.00, 2000.00, 7000.00),
('COV019', 'PAT019', 'PLAN004', 'CIG019012', 'Primary', '2024-01-01', '2025-12-31', 35.00, 1200.00, 5500.00),
('COV020', 'PAT020', 'PLAN005', 'KP020123', 'Primary', '2024-01-01', '2025-12-31', 15.00, 500.00, 3000.00),
-- Secondary insurance for some patients
('COV021', 'PAT001', 'PLAN002', 'UHC001SEC', 'Secondary', '2024-01-01', '2025-12-31', 10.00, 500.00, 2500.00),
('COV022', 'PAT005', 'PLAN003', 'AET005SEC', 'Secondary', '2024-01-01', '2025-12-31', 15.00, 750.00, 3000.00),
('COV023', 'PAT010', 'PLAN001', 'BCBS010SEC', 'Secondary', '2024-01-01', '2025-12-31', 20.00, 800.00, 4000.00);

-- Insert Encounters (100 encounters for 100 claims)
INSERT INTO encounter (encounter_id, patient_id, facility_id, encounter_type, admission_date, discharge_date, attending_provider_id, admitting_diagnosis_code)
SELECT 
    'ENC' || LPAD(ROW_NUMBER() OVER (ORDER BY p.patient_id), 3, '0') as encounter_id,
    p.patient_id,
    f.facility_id,
    CASE 
        WHEN ROW_NUMBER() OVER (ORDER BY p.patient_id) % 4 = 0 THEN 'Inpatient'
        WHEN ROW_NUMBER() OVER (ORDER BY p.patient_id) % 4 = 1 THEN 'Outpatient'
        WHEN ROW_NUMBER() OVER (ORDER BY p.patient_id) % 4 = 2 THEN 'Emergency'
        ELSE 'Outpatient'
    END as encounter_type,
    DATEADD('day', -ROW_NUMBER() OVER (ORDER BY p.patient_id) * 3, '2025-01-15'::DATE) as admission_date,
    DATEADD('day', -ROW_NUMBER() OVER (ORDER BY p.patient_id) * 3 + 1, '2025-01-15'::DATE) as discharge_date,
    pr.provider_id,
    CASE 
        WHEN ROW_NUMBER() OVER (ORDER BY p.patient_id) % 5 = 0 THEN 'I10'
        WHEN ROW_NUMBER() OVER (ORDER BY p.patient_id) % 5 = 1 THEN 'E11.9'
        WHEN ROW_NUMBER() OVER (ORDER BY p.patient_id) % 5 = 2 THEN 'J45.909'
        WHEN ROW_NUMBER() OVER (ORDER BY p.patient_id) % 5 = 3 THEN 'M79.3'
        ELSE 'R50.9'
    END as admitting_diagnosis_code
FROM 
    (SELECT patient_id FROM patient) p
    CROSS JOIN (SELECT facility_id FROM facility) f
    CROSS JOIN (SELECT provider_id FROM provider) pr
LIMIT 100;

-- Insert Diagnoses (2-3 per encounter)
INSERT INTO diagnosis (diagnosis_id, encounter_id, diagnosis_code, diagnosis_type, diagnosis_description, diagnosis_rank, present_on_admission)
SELECT 
    'DIAG' || LPAD(ROW_NUMBER() OVER (ORDER BY e.encounter_id, d.rank), 4, '0') as diagnosis_id,
    e.encounter_id,
    d.diagnosis_code,
    'ICD-10-CM' as diagnosis_type,
    d.diagnosis_description,
    d.rank as diagnosis_rank,
    CASE WHEN d.rank = 1 THEN 'Y' ELSE 'N' END as present_on_admission
FROM 
    encounter e
    CROSS JOIN (
        SELECT 1 as rank, 'I10' as diagnosis_code, 'Essential (primary) hypertension' as diagnosis_description
        UNION ALL
        SELECT 2, 'E11.9', 'Type 2 diabetes mellitus without complications'
        UNION ALL
        SELECT 3, 'K21.9', 'Gastro-esophageal reflux disease without esophagitis'
    ) d
WHERE e.encounter_id <= 'ENC050'
UNION ALL
SELECT 
    'DIAG' || LPAD(ROW_NUMBER() OVER (ORDER BY e.encounter_id) + 150, 4, '0') as diagnosis_id,
    e.encounter_id,
    CASE 
        WHEN ROW_NUMBER() OVER (ORDER BY e.encounter_id) % 2 = 0 THEN 'J45.909'
        ELSE 'M79.3'
    END as diagnosis_code,
    'ICD-10-CM' as diagnosis_type,
    CASE 
        WHEN ROW_NUMBER() OVER (ORDER BY e.encounter_id) % 2 = 0 THEN 'Unspecified asthma, uncomplicated'
        ELSE 'Myalgia'
    END as diagnosis_description,
    1 as diagnosis_rank,
    'Y' as present_on_admission
FROM encounter e
WHERE e.encounter_id > 'ENC050';

-- Insert Procedures (2-3 per encounter)
INSERT INTO procedure (procedure_id, encounter_id, procedure_code, procedure_type, procedure_description, procedure_date, performing_provider_id)
SELECT 
    'PROC' || LPAD(ROW_NUMBER() OVER (ORDER BY e.encounter_id, p.seq), 4, '0') as procedure_id,
    e.encounter_id,
    p.procedure_code,
    'CPT' as procedure_type,
    p.procedure_description,
    e.admission_date as procedure_date,
    e.attending_provider_id as performing_provider_id
FROM 
    encounter e
    CROSS JOIN (
        SELECT 1 as seq, '99213' as procedure_code, 'Office/outpatient visit, established patient' as procedure_description
        UNION ALL
        SELECT 2, '80053', 'Comprehensive metabolic panel'
        UNION ALL
        SELECT 3, '85025', 'Complete blood count with differential'
    ) p
WHERE e.encounter_type = 'Outpatient'
UNION ALL
SELECT 
    'PROC' || LPAD(ROW_NUMBER() OVER (ORDER BY e.encounter_id) + 500, 4, '0') as procedure_id,
    e.encounter_id,
    CASE 
        WHEN e.encounter_type = 'Inpatient' THEN '99223'
        WHEN e.encounter_type = 'Emergency' THEN '99284'
        ELSE '99214'
    END as procedure_code,
    'CPT' as procedure_type,
    CASE 
        WHEN e.encounter_type = 'Inpatient' THEN 'Initial hospital care, high complexity'
        WHEN e.encounter_type = 'Emergency' THEN 'Emergency dept visit, high complexity'
        ELSE 'Office/outpatient visit, established patient, moderate'
    END as procedure_description,
    e.admission_date as procedure_date,
    e.attending_provider_id as performing_provider_id
FROM encounter e
WHERE e.encounter_type != 'Outpatient';

-- Insert Prior Authorizations (30 authorizations for select claims)
INSERT INTO prior_authorization (auth_id, auth_number, patient_id, plan_id, requesting_provider_id, procedure_code, auth_status, approved_units, effective_date, expiration_date)
SELECT 
    'AUTH' || LPAD(ROW_NUMBER() OVER (ORDER BY p.patient_id), 3, '0') as auth_id,
    'AUTH' || p.patient_id || LPAD(ROW_NUMBER() OVER (PARTITION BY p.patient_id ORDER BY p.patient_id), 3, '0') as auth_number,
    p.patient_id,
    pi.plan_id,
    pr.provider_id,
    CASE 
        WHEN ROW_NUMBER() OVER (ORDER BY p.patient_id) % 3 = 0 THEN '70553'
        WHEN ROW_NUMBER() OVER (ORDER BY p.patient_id) % 3 = 1 THEN '27447'
        ELSE '43239'
    END as procedure_code,
    'Approved' as auth_status,
    1 as approved_units,
    '2024-12-01' as effective_date,
    '2025-06-30' as expiration_date
FROM 
    (SELECT patient_id FROM patient LIMIT 10) p
    JOIN patient_insurance pi ON p.patient_id = pi.patient_id AND pi.coverage_type = 'Primary'
    CROSS JOIN (SELECT provider_id FROM provider LIMIT 3) pr
LIMIT 30;

-- Insert Claims (100 claims)
INSERT INTO claim (claim_id, claim_number, encounter_id, patient_id, plan_id, claim_type, claim_status, 
    service_date_from, service_date_to, submission_date, billing_provider_id, rendering_provider_id, 
    facility_id, auth_id, total_charge_amount, total_allowed_amount, total_paid_amount, 
    patient_responsibility, deductible_amount, copay_amount, coinsurance_amount)
SELECT 
    'CLM' || LPAD(e.encounter_id, 3, '0') as claim_id,
    'CLM' || e.encounter_id || '2025' as claim_number,
    e.encounter_id,
    e.patient_id,
    pi.plan_id,
    CASE 
        WHEN e.encounter_type = 'Inpatient' THEN 'Institutional'
        ELSE 'Professional'
    END as claim_type,
    CASE 
        WHEN ROW_NUMBER() OVER (ORDER BY e.encounter_id) % 10 = 0 THEN 'Denied'
        WHEN ROW_NUMBER() OVER (ORDER BY e.encounter_id) % 10 IN (1,2) THEN 'Pending'
        ELSE 'Approved'
    END as claim_status,
    e.admission_date::DATE as service_date_from,
    e.discharge_date::DATE as service_date_to,
    DATEADD('day', 5, e.discharge_date)::DATE as submission_date,
    e.attending_provider_id as billing_provider_id,
    e.attending_provider_id as rendering_provider_id,
    e.facility_id,
    CASE 
        WHEN ROW_NUMBER() OVER (ORDER BY e.encounter_id) <= 30 THEN 'AUTH' || LPAD(ROW_NUMBER() OVER (ORDER BY e.encounter_id), 3, '0')
        ELSE NULL
    END as auth_id,
    CASE 
        WHEN e.encounter_type = 'Inpatient' THEN 15000.00 + (RANDOM() * 10000)::DECIMAL(12,2)
        WHEN e.encounter_type = 'Emergency' THEN 3000.00 + (RANDOM() * 2000)::DECIMAL(12,2)
        ELSE 500.00 + (RANDOM() * 500)::DECIMAL(12,2)
    END as total_charge_amount,
    CASE 
        WHEN e.encounter_type = 'Inpatient' THEN 10000.00 + (RANDOM() * 5000)::DECIMAL(12,2)
        WHEN e.encounter_type = 'Emergency' THEN 2000.00 + (RANDOM() * 1000)::DECIMAL(12,2)
        ELSE 300.00 + (RANDOM() * 200)::DECIMAL(12,2)
    END as total_allowed_amount,
    CASE 
        WHEN e.encounter_type = 'Inpatient' THEN 8000.00 + (RANDOM() * 4000)::DECIMAL(12,2)
        WHEN e.encounter_type = 'Emergency' THEN 1500.00 + (RANDOM() * 800)::DECIMAL(12,2)
        ELSE 250.00 + (RANDOM() * 150)::DECIMAL(12,2)
    END as total_paid_amount,
    CASE 
        WHEN e.encounter_type = 'Inpatient' THEN 2000.00 + (RANDOM() * 1000)::DECIMAL(12,2)
        WHEN e.encounter_type = 'Emergency' THEN 500.00 + (RANDOM() * 200)::DECIMAL(12,2)
        ELSE 50.00 + (RANDOM() * 50)::DECIMAL(12,2)
    END as patient_responsibility,
    CASE 
        WHEN ROW_NUMBER() OVER (ORDER BY e.encounter_id) % 3 = 0 THEN 250.00
        ELSE 0.00
    END as deductible_amount,
    pi.copay_amount,
    CASE 
        WHEN e.encounter_type = 'Inpatient' THEN 500.00
        WHEN e.encounter_type = 'Emergency' THEN 200.00
        ELSE 0.00
    END as coinsurance_amount
FROM 
    encounter e
    JOIN patient_insurance pi ON e.patient_id = pi.patient_id AND pi.coverage_type = 'Primary'
LIMIT 100;

-- Insert Claim Line Items (3-5 per claim)
INSERT INTO claim_line_item (line_item_id, claim_id, line_number, procedure_code, procedure_type, 
    procedure_description, service_date, place_of_service, units, charge_amount, 
    allowed_amount, paid_amount, revenue_code)
SELECT 
    'LINE' || LPAD(ROW_NUMBER() OVER (ORDER BY c.claim_id, l.line_num), 5, '0') as line_item_id,
    c.claim_id,
    l.line_num as line_number,
    l.procedure_code,
    'CPT' as procedure_type,
    l.procedure_description,
    c.service_date_from as service_date,
    CASE 
        WHEN c.claim_type = 'Institutional' THEN '21'
        ELSE '11'
    END as place_of_service,
    l.units,
    l.charge_amount,
    l.charge_amount * 0.6 as allowed_amount,
    l.charge_amount * 0.5 as paid_amount,
    CASE 
        WHEN c.claim_type = 'Institutional' THEN l.revenue_code
        ELSE NULL
    END as revenue_code
FROM 
    claim c
    CROSS JOIN (
        SELECT 1 as line_num, '99213' as procedure_code, 'Office visit' as procedure_description, 1 as units, 250.00 as charge_amount, '0510' as revenue_code
        UNION ALL
        SELECT 2, '80053', 'Metabolic panel', 1, 150.00, '0301'
        UNION ALL
        SELECT 3, '85025', 'Blood count', 1, 75.00, '0301'
        UNION ALL
        SELECT 4, '71020', 'Chest X-ray', 1, 200.00, '0320'
        UNION ALL
        SELECT 5, '93000', 'EKG', 1, 100.00, '0730'
    ) l
WHERE c.claim_id <= 'CLM050'
UNION ALL
SELECT 
    'LINE' || LPAD(ROW_NUMBER() OVER (ORDER BY c.claim_id) + 250, 5, '0') as line_item_id,
    c.claim_id,
    ROW_NUMBER() OVER (PARTITION BY c.claim_id ORDER BY c.claim_id) as line_number,
    CASE 
        WHEN ROW_NUMBER() OVER (PARTITION BY c.claim_id ORDER BY c.claim_id) = 1 THEN '99223'
        WHEN ROW_NUMBER() OVER (PARTITION BY c.claim_id ORDER BY c.claim_id) = 2 THEN '80053'
        ELSE '85025'
    END as procedure_code,
    'CPT' as procedure_type,
    CASE 
        WHEN ROW_NUMBER() OVER (PARTITION BY c.claim_id ORDER BY c.claim_id) = 1 THEN 'Initial hospital care'
        WHEN ROW_NUMBER() OVER (PARTITION BY c.claim_id ORDER BY c.claim_id) = 2 THEN 'Metabolic panel'
        ELSE 'Blood count'
    END as procedure_description,
    c.service_date_from as service_date,
    '21' as place_of_service,
    1 as units,
    CASE 
        WHEN ROW_NUMBER() OVER (PARTITION BY c.claim_id ORDER BY c.claim_id) = 1 THEN 500.00
        WHEN ROW_NUMBER() OVER (PARTITION BY c.claim_id ORDER BY c.claim_id) = 2 THEN 150.00
        ELSE 75.00
    END as charge_amount,
    CASE 
        WHEN ROW_NUMBER() OVER (PARTITION BY c.claim_id ORDER BY c.claim_id) = 1 THEN 400.00
        WHEN ROW_NUMBER() OVER (PARTITION BY c.claim_id ORDER BY c.claim_id) = 2 THEN 100.00
        ELSE 50.00
    END as allowed_amount,
    CASE 
        WHEN ROW_NUMBER() OVER (PARTITION BY c.claim_id ORDER BY c.claim_id) = 1 THEN 350.00
        WHEN ROW_NUMBER() OVER (PARTITION BY c.claim_id ORDER BY c.claim_id) = 2 THEN 80.00
        ELSE 40.00
    END as paid_amount,
    NULL as revenue_code
FROM claim c
WHERE c.claim_id > 'CLM050'
LIMIT 150;

-- Insert Payments (for approved claims)
INSERT INTO payment (payment_id, claim_id, payment_number, payment_date, payment_method, 
    check_eft_number, payment_amount, applied_amount)
SELECT 
    'PAY' || LPAD(ROW_NUMBER() OVER (ORDER BY c.claim_id), 4, '0') as payment_id,
    c.claim_id,
    'CHK' || c.claim_id as payment_number,
    DATEADD('day', 30, c.submission_date) as payment_date,
    CASE 
        WHEN ROW_NUMBER() OVER (ORDER BY c.claim_id) % 2 = 0 THEN 'EFT'
        ELSE 'Check'
    END as payment_method,
    CASE 
        WHEN ROW_NUMBER() OVER (ORDER BY c.claim_id) % 2 = 0 THEN 'EFT' || LPAD(ROW_NUMBER() OVER (ORDER BY c.claim_id), 6, '0')
        ELSE 'CHK' || LPAD(ROW_NUMBER() OVER (ORDER BY c.claim_id), 6, '0')
    END as check_eft_number,
    c.total_paid_amount as payment_amount,
    c.total_paid_amount as applied_amount
FROM claim c
WHERE c.claim_status = 'Approved';

-- Insert Payment Adjustments
INSERT INTO payment_adjustment (adjustment_id, payment_id, claim_id, adjustment_code, 
    adjustment_reason, adjustment_amount, adjustment_date)
SELECT 
    'ADJ' || LPAD(ROW_NUMBER() OVER (ORDER BY p.payment_id), 5, '0') as adjustment_id,
    p.payment_id,
    p.claim_id,
    CASE 
        WHEN ROW_NUMBER() OVER (ORDER BY p.payment_id) % 3 = 0 THEN 'CO45'
        WHEN ROW_NUMBER() OVER (ORDER BY p.payment_id) % 3 = 1 THEN 'PR1'
        ELSE 'CO97'
    END as adjustment_code,
    CASE 
        WHEN ROW_NUMBER() OVER (ORDER BY p.payment_id) % 3 = 0 THEN 'Charges exceed fee schedule'
        WHEN ROW_NUMBER() OVER (ORDER BY p.payment_id) % 3 = 1 THEN 'Deductible'
        ELSE 'Payment included in allowance for another service'
    END as adjustment_reason,
    (c.total_charge_amount - c.total_allowed_amount) as adjustment_amount,
    p.payment_date as adjustment_date
FROM 
    payment p
    JOIN claim c ON p.claim_id = c.claim_id;

-- Insert Denials (for denied claims)
INSERT INTO denial (denial_id, claim_id, denial_date, denial_code, denial_reason, 
    denial_category, appeal_deadline, appeal_status)
SELECT 
    'DEN' || LPAD(ROW_NUMBER() OVER (ORDER BY c.claim_id), 3, '0') as denial_id,
    c.claim_id,
    DATEADD('day', 15, c.submission_date) as denial_date,
    CASE 
        WHEN ROW_NUMBER() OVER (ORDER BY c.claim_id) % 3 = 0 THEN 'CO50'
        WHEN ROW_NUMBER() OVER (ORDER BY c.claim_id) % 3 = 1 THEN 'CO197'
        ELSE 'CO151'
    END as denial_code,
    CASE 
        WHEN ROW_NUMBER() OVER (ORDER BY c.claim_id) % 3 = 0 THEN 'Service not medically necessary'
        WHEN ROW_NUMBER() OVER (ORDER BY c.claim_id) % 3 = 1 THEN 'Prior authorization required'
        ELSE 'Payment adjusted based on payer policies'
    END as denial_reason,
    CASE 
        WHEN ROW_NUMBER() OVER (ORDER BY c.claim_id) % 3 = 0 THEN 'Medical Necessity'
        WHEN ROW_NUMBER() OVER (ORDER BY c.claim_id) % 3 = 1 THEN 'Authorization'
        ELSE 'Eligibility'
    END as denial_category,
    DATEADD('day', 90, DATEADD('day', 15, c.submission_date)) as appeal_deadline,
    CASE 
        WHEN ROW_NUMBER() OVER (ORDER BY c.claim_id) % 2 = 0 THEN 'Appealed'
        ELSE 'Not Appealed'
    END as appeal_status
FROM claim c
WHERE c.claim_status = 'Denied';

-- Insert Appeals (for some denied claims)
INSERT INTO appeal (appeal_id, denial_id, claim_id, appeal_level, appeal_date, 
    appeal_reason, appeal_status, appeal_decision_date, appeal_outcome_amount)
SELECT 
    'APP' || LPAD(ROW_NUMBER() OVER (ORDER BY d.denial_id), 3, '0') as appeal_id,
    d.denial_id,
    d.claim_id,
    1 as appeal_level,
    DATEADD('day', 30, d.denial_date) as appeal_date,
    'Medical records support medical necessity of service. Patient met criteria for procedure based on documented symptoms and failed conservative treatment.' as appeal_reason,
    CASE 
        WHEN ROW_NUMBER() OVER (ORDER BY d.denial_id) % 3 = 0 THEN 'Approved'
        WHEN ROW_NUMBER() OVER (ORDER BY d.denial_id) % 3 = 1 THEN 'Denied'
        ELSE 'Pending'
    END as appeal_status,
    CASE 
        WHEN ROW_NUMBER() OVER (ORDER BY d.denial_id) % 3 != 2 THEN DATEADD('day', 45, d.denial_date)
        ELSE NULL
    END as appeal_decision_date,
    CASE 
        WHEN ROW_NUMBER() OVER (ORDER BY d.denial_id) % 3 = 0 THEN c.total_allowed_amount * 0.8
        ELSE 0.00
    END as appeal_outcome_amount
FROM 
    denial d
    JOIN claim c ON d.claim_id = c.claim_id
WHERE d.appeal_status = 'Appealed';

-- Insert Coordination of Benefits (for patients with secondary insurance)
INSERT INTO coordination_of_benefits (cob_id, claim_id, patient_id, primary_plan_id, 
    secondary_plan_id, primary_paid_amount, secondary_paid_amount, patient_paid_amount, cob_adjustment_amount)
SELECT 
    'COB' || LPAD(ROW_NUMBER() OVER (ORDER BY c.claim_id), 3, '0') as cob_id,
    c.claim_id,
    c.patient_id,
    pi1.plan_id as primary_plan_id,
    pi2.plan_id as secondary_plan_id,
    c.total_paid_amount as primary_paid_amount,
    (c.total_allowed_amount - c.total_paid_amount) * 0.8 as secondary_paid_amount,
    c.patient_responsibility * 0.2 as patient_paid_amount,
    0.00 as cob_adjustment_amount
FROM 
    claim c
    JOIN patient_insurance pi1 ON c.patient_id = pi1.patient_id AND pi1.coverage_type = 'Primary'
    JOIN patient_insurance pi2 ON c.patient_id = pi2.patient_id AND pi2.coverage_type = 'Secondary'
WHERE c.patient_id IN ('PAT001', 'PAT005', 'PAT010');

-- Insert Fee Schedule entries
INSERT INTO fee_schedule (fee_schedule_id, plan_id, procedure_code, procedure_type, 
    effective_date, termination_date, allowed_amount, relative_value_unit)
SELECT 
    'FEE' || LPAD(ROW_NUMBER() OVER (ORDER BY p.plan_id, c.code), 5, '0') as fee_schedule_id,
    p.plan_id,
    c.code as procedure_code,
    'CPT' as procedure_type,
    '2024-01-01' as effective_date,
    '2025-12-31' as termination_date,
    c.allowed_amount,
    c.rvu as relative_value_unit
FROM 
    insurance_plan p
    CROSS JOIN (
        SELECT '99213' as code, 150.00 as allowed_amount, 2.18 as rvu
        UNION ALL SELECT '99214', 225.00, 3.29
        UNION ALL SELECT '99223', 450.00, 5.81
        UNION ALL SELECT '99284', 350.00, 4.64
        UNION ALL SELECT '80053', 90.00, 1.20
        UNION ALL SELECT '85025', 45.00, 0.65
        UNION ALL SELECT '71020', 120.00, 1.55
        UNION ALL SELECT '93000', 60.00, 0.85
        UNION ALL SELECT '70553', 1200.00, 15.50
        UNION ALL SELECT '27447', 8500.00, 95.25
        UNION ALL SELECT '43239', 2200.00, 28.45
    ) c;

-- Verify record counts
SELECT 'Patients' as entity, COUNT(*) as count FROM patient
UNION ALL SELECT 'Providers', COUNT(*) FROM provider
UNION ALL SELECT 'Facilities', COUNT(*) FROM facility
UNION ALL SELECT 'Insurance Plans', COUNT(*) FROM insurance_plan
UNION ALL SELECT 'Patient Insurance', COUNT(*) FROM patient_insurance
UNION ALL SELECT 'Encounters', COUNT(*) FROM encounter
UNION ALL SELECT 'Diagnoses', COUNT(*) FROM diagnosis
UNION ALL SELECT 'Procedures', COUNT(*) FROM procedure
UNION ALL SELECT 'Prior Authorizations', COUNT(*) FROM prior_authorization
UNION ALL SELECT 'Claims', COUNT(*) FROM claim
UNION ALL SELECT 'Claim Line Items', COUNT(*) FROM claim_line_item
UNION ALL SELECT 'Payments', COUNT(*) FROM payment
UNION ALL SELECT 'Payment Adjustments', COUNT(*) FROM payment_adjustment
UNION ALL SELECT 'Denials', COUNT(*) FROM denial
UNION ALL SELECT 'Appeals', COUNT(*) FROM appeal
UNION ALL SELECT 'COB Records', COUNT(*) FROM coordination_of_benefits
UNION ALL SELECT 'Fee Schedule Entries', COUNT(*) FROM fee_schedule;