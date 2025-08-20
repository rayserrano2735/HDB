-- Healthcare Claims Database DDL for Snowflake
-- Create Schema
CREATE SCHEMA IF NOT EXISTS healthcare;
USE SCHEMA healthcare;

-- Patient Entity
CREATE TABLE IF NOT EXISTS patient (
    patient_id VARCHAR(50) PRIMARY KEY,
    medical_record_number VARCHAR(50) UNIQUE,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    date_of_birth DATE,
    gender VARCHAR(10),
    ssn VARCHAR(11),
    address_line1 VARCHAR(200),
    address_line2 VARCHAR(200),
    city VARCHAR(100),
    state VARCHAR(2),
    zip_code VARCHAR(10),
    phone_number VARCHAR(20),
    email VARCHAR(200),
    created_date TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    updated_date TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

-- Provider Entity
CREATE TABLE IF NOT EXISTS provider (
    provider_id VARCHAR(50) PRIMARY KEY,
    npi VARCHAR(10) UNIQUE,
    provider_type VARCHAR(50),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    specialty VARCHAR(100),
    tax_id VARCHAR(20),
    address_line1 VARCHAR(200),
    city VARCHAR(100),
    state VARCHAR(2),
    zip_code VARCHAR(10),
    phone_number VARCHAR(20),
    created_date TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    updated_date TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

-- Facility Entity
CREATE TABLE IF NOT EXISTS facility (
    facility_id VARCHAR(50) PRIMARY KEY,
    facility_name VARCHAR(200),
    facility_type VARCHAR(50),
    npi VARCHAR(10),
    tax_id VARCHAR(20),
    address_line1 VARCHAR(200),
    address_line2 VARCHAR(200),
    city VARCHAR(100),
    state VARCHAR(2),
    zip_code VARCHAR(10),
    phone_number VARCHAR(20),
    created_date TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    updated_date TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

-- Insurance Plan Entity
CREATE TABLE IF NOT EXISTS insurance_plan (
    plan_id VARCHAR(50) PRIMARY KEY,
    payer_id VARCHAR(50),
    payer_name VARCHAR(200),
    plan_name VARCHAR(200),
    plan_type VARCHAR(50), -- HMO, PPO, POS, etc.
    group_number VARCHAR(50),
    created_date TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    updated_date TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

-- Patient Insurance Coverage
CREATE TABLE IF NOT EXISTS patient_insurance (
    coverage_id VARCHAR(50) PRIMARY KEY,
    patient_id VARCHAR(50),
    plan_id VARCHAR(50),
    member_id VARCHAR(50),
    coverage_type VARCHAR(20), -- Primary, Secondary, Tertiary
    effective_date DATE,
    termination_date DATE,
    copay_amount DECIMAL(10,2),
    deductible_amount DECIMAL(10,2),
    out_of_pocket_max DECIMAL(10,2),
    created_date TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    updated_date TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (plan_id) REFERENCES insurance_plan(plan_id)
);

-- Encounter Entity
CREATE TABLE IF NOT EXISTS encounter (
    encounter_id VARCHAR(50) PRIMARY KEY,
    patient_id VARCHAR(50),
    facility_id VARCHAR(50),
    encounter_type VARCHAR(50), -- Inpatient, Outpatient, Emergency
    admission_date TIMESTAMP_NTZ,
    discharge_date TIMESTAMP_NTZ,
    attending_provider_id VARCHAR(50),
    admitting_diagnosis_code VARCHAR(20),
    discharge_disposition VARCHAR(50),
    created_date TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    updated_date TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (facility_id) REFERENCES facility(facility_id),
    FOREIGN KEY (attending_provider_id) REFERENCES provider(provider_id)
);

-- Diagnosis Entity
CREATE TABLE IF NOT EXISTS diagnosis (
    diagnosis_id VARCHAR(50) PRIMARY KEY,
    encounter_id VARCHAR(50),
    diagnosis_code VARCHAR(20),
    diagnosis_type VARCHAR(10), -- ICD-10-CM
    diagnosis_description VARCHAR(500),
    diagnosis_rank NUMBER(2), -- Primary, Secondary, etc.
    present_on_admission VARCHAR(1),
    created_date TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    FOREIGN KEY (encounter_id) REFERENCES encounter(encounter_id)
);

-- Procedure Entity
CREATE TABLE IF NOT EXISTS procedure (
    procedure_id VARCHAR(50) PRIMARY KEY,
    encounter_id VARCHAR(50),
    procedure_code VARCHAR(20),
    procedure_type VARCHAR(10), -- CPT, HCPCS, ICD-10-PCS
    procedure_description VARCHAR(500),
    procedure_date TIMESTAMP_NTZ,
    performing_provider_id VARCHAR(50),
    modifier_1 VARCHAR(2),
    modifier_2 VARCHAR(2),
    modifier_3 VARCHAR(2),
    modifier_4 VARCHAR(2),
    created_date TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    FOREIGN KEY (encounter_id) REFERENCES encounter(encounter_id),
    FOREIGN KEY (performing_provider_id) REFERENCES provider(provider_id)
);

-- Prior Authorization Entity
CREATE TABLE IF NOT EXISTS prior_authorization (
    auth_id VARCHAR(50) PRIMARY KEY,
    auth_number VARCHAR(50) UNIQUE,
    patient_id VARCHAR(50),
    plan_id VARCHAR(50),
    requesting_provider_id VARCHAR(50),
    procedure_code VARCHAR(20),
    auth_status VARCHAR(20), -- Approved, Denied, Pending
    approved_units NUMBER(10),
    effective_date DATE,
    expiration_date DATE,
    created_date TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    updated_date TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (plan_id) REFERENCES insurance_plan(plan_id),
    FOREIGN KEY (requesting_provider_id) REFERENCES provider(provider_id)
);

-- Claim Entity
CREATE TABLE IF NOT EXISTS claim (
    claim_id VARCHAR(50) PRIMARY KEY,
    claim_number VARCHAR(50) UNIQUE,
    encounter_id VARCHAR(50),
    patient_id VARCHAR(50),
    plan_id VARCHAR(50),
    claim_type VARCHAR(20), -- Professional, Institutional, Dental
    claim_status VARCHAR(20), -- Submitted, Pending, Approved, Denied, Appealed
    service_date_from DATE,
    service_date_to DATE,
    submission_date DATE,
    billing_provider_id VARCHAR(50),
    rendering_provider_id VARCHAR(50),
    referring_provider_id VARCHAR(50),
    facility_id VARCHAR(50),
    auth_id VARCHAR(50),
    total_charge_amount DECIMAL(12,2),
    total_allowed_amount DECIMAL(12,2),
    total_paid_amount DECIMAL(12,2),
    patient_responsibility DECIMAL(12,2),
    deductible_amount DECIMAL(12,2),
    copay_amount DECIMAL(12,2),
    coinsurance_amount DECIMAL(12,2),
    primary_payer_claim_id VARCHAR(50), -- For COB
    created_date TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    updated_date TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    FOREIGN KEY (encounter_id) REFERENCES encounter(encounter_id),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (plan_id) REFERENCES insurance_plan(plan_id),
    FOREIGN KEY (billing_provider_id) REFERENCES provider(provider_id),
    FOREIGN KEY (rendering_provider_id) REFERENCES provider(provider_id),
    FOREIGN KEY (referring_provider_id) REFERENCES provider(provider_id),
    FOREIGN KEY (facility_id) REFERENCES facility(facility_id),
    FOREIGN KEY (auth_id) REFERENCES prior_authorization(auth_id)
);

-- Claim Line Item Entity
CREATE TABLE IF NOT EXISTS claim_line_item (
    line_item_id VARCHAR(50) PRIMARY KEY,
    claim_id VARCHAR(50),
    line_number NUMBER(5),
    procedure_code VARCHAR(20),
    procedure_type VARCHAR(10), -- CPT, HCPCS
    procedure_description VARCHAR(500),
    modifier_1 VARCHAR(2),
    modifier_2 VARCHAR(2),
    modifier_3 VARCHAR(2),
    modifier_4 VARCHAR(2),
    service_date DATE,
    place_of_service VARCHAR(2),
    units DECIMAL(10,2),
    charge_amount DECIMAL(12,2),
    allowed_amount DECIMAL(12,2),
    paid_amount DECIMAL(12,2),
    denial_reason_code VARCHAR(10),
    revenue_code VARCHAR(4), -- For institutional claims
    ndc_code VARCHAR(20), -- For drug claims
    created_date TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    updated_date TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    FOREIGN KEY (claim_id) REFERENCES claim(claim_id)
);

-- Payment/Remittance Entity
CREATE TABLE IF NOT EXISTS payment (
    payment_id VARCHAR(50) PRIMARY KEY,
    claim_id VARCHAR(50),
    payment_number VARCHAR(50),
    payment_date DATE,
    payment_method VARCHAR(20), -- Check, EFT, Credit
    check_eft_number VARCHAR(50),
    payment_amount DECIMAL(12,2),
    applied_amount DECIMAL(12,2),
    created_date TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    FOREIGN KEY (claim_id) REFERENCES claim(claim_id)
);

-- Payment Adjustment Entity
CREATE TABLE IF NOT EXISTS payment_adjustment (
    adjustment_id VARCHAR(50) PRIMARY KEY,
    payment_id VARCHAR(50),
    claim_id VARCHAR(50),
    line_item_id VARCHAR(50),
    adjustment_code VARCHAR(10),
    adjustment_reason VARCHAR(500),
    adjustment_amount DECIMAL(12,2),
    adjustment_date DATE,
    created_date TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    FOREIGN KEY (payment_id) REFERENCES payment(payment_id),
    FOREIGN KEY (claim_id) REFERENCES claim(claim_id),
    FOREIGN KEY (line_item_id) REFERENCES claim_line_item(line_item_id)
);

-- Denial Entity
CREATE TABLE IF NOT EXISTS denial (
    denial_id VARCHAR(50) PRIMARY KEY,
    claim_id VARCHAR(50),
    line_item_id VARCHAR(50),
    denial_date DATE,
    denial_code VARCHAR(10),
    denial_reason VARCHAR(500),
    denial_category VARCHAR(50), -- Medical Necessity, Authorization, Eligibility
    appeal_deadline DATE,
    appeal_status VARCHAR(20), -- Not Appealed, Appealed, Won, Lost
    created_date TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    updated_date TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    FOREIGN KEY (claim_id) REFERENCES claim(claim_id),
    FOREIGN KEY (line_item_id) REFERENCES claim_line_item(line_item_id)
);

-- Appeal Entity
CREATE TABLE IF NOT EXISTS appeal (
    appeal_id VARCHAR(50) PRIMARY KEY,
    denial_id VARCHAR(50),
    claim_id VARCHAR(50),
    appeal_level NUMBER(1), -- 1st, 2nd, 3rd level
    appeal_date DATE,
    appeal_reason TEXT,
    appeal_status VARCHAR(20), -- Pending, Approved, Denied
    appeal_decision_date DATE,
    appeal_outcome_amount DECIMAL(12,2),
    created_date TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    updated_date TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    FOREIGN KEY (denial_id) REFERENCES denial(denial_id),
    FOREIGN KEY (claim_id) REFERENCES claim(claim_id)
);

-- Coordination of Benefits (COB) Entity
CREATE TABLE IF NOT EXISTS coordination_of_benefits (
    cob_id VARCHAR(50) PRIMARY KEY,
    claim_id VARCHAR(50),
    patient_id VARCHAR(50),
    primary_plan_id VARCHAR(50),
    secondary_plan_id VARCHAR(50),
    primary_paid_amount DECIMAL(12,2),
    secondary_paid_amount DECIMAL(12,2),
    patient_paid_amount DECIMAL(12,2),
    cob_adjustment_amount DECIMAL(12,2),
    created_date TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    FOREIGN KEY (claim_id) REFERENCES claim(claim_id),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (primary_plan_id) REFERENCES insurance_plan(plan_id),
    FOREIGN KEY (secondary_plan_id) REFERENCES insurance_plan(plan_id)
);

-- Fee Schedule Entity
CREATE TABLE IF NOT EXISTS fee_schedule (
    fee_schedule_id VARCHAR(50) PRIMARY KEY,
    plan_id VARCHAR(50),
    procedure_code VARCHAR(20),
    procedure_type VARCHAR(10),
    effective_date DATE,
    termination_date DATE,
    allowed_amount DECIMAL(12,2),
    relative_value_unit DECIMAL(10,4),
    created_date TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    updated_date TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    FOREIGN KEY (plan_id) REFERENCES insurance_plan(plan_id)
);

-- Create indexes for performance
CREATE INDEX idx_claim_patient ON claim(patient_id);
CREATE INDEX idx_claim_status ON claim(claim_status);
CREATE INDEX idx_claim_dates ON claim(service_date_from, service_date_to);
CREATE INDEX idx_claim_line_claim ON claim_line_item(claim_id);
CREATE INDEX idx_payment_claim ON payment(claim_id);
CREATE INDEX idx_denial_claim ON denial(claim_id);
CREATE INDEX idx_patient_insurance_patient ON patient_insurance(patient_id);
CREATE INDEX idx_encounter_patient ON encounter(patient_id);