-- RAW Schema DDL for Healthcare Claims Source Data
-- This schema stores raw CSV data before transformation by dbt
-- All columns are VARCHAR to handle any data quality issues in source files

-- Create RAW schema
CREATE SCHEMA IF NOT EXISTS raw;
USE SCHEMA raw;

-- Raw Patients Table
CREATE OR REPLACE TABLE raw.patients (
    patient_id VARCHAR(16777216),
    medical_record_number VARCHAR(16777216),
    first_name VARCHAR(16777216),
    last_name VARCHAR(16777216),
    date_of_birth VARCHAR(16777216),
    gender VARCHAR(16777216),
    ssn VARCHAR(16777216),
    address_line1 VARCHAR(16777216),
    address_line2 VARCHAR(16777216),
    city VARCHAR(16777216),
    state VARCHAR(16777216),
    zip_code VARCHAR(16777216),
    phone_number VARCHAR(16777216),
    email VARCHAR(16777216),
    _loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    _file_name VARCHAR(16777216)
);

-- Raw Providers Table
CREATE OR REPLACE TABLE raw.providers (
    provider_id VARCHAR(16777216),
    npi VARCHAR(16777216),
    provider_type VARCHAR(16777216),
    first_name VARCHAR(16777216),
    last_name VARCHAR(16777216),
    specialty VARCHAR(16777216),
    tax_id VARCHAR(16777216),
    address_line1 VARCHAR(16777216),
    address_line2 VARCHAR(16777216),
    city VARCHAR(16777216),
    state VARCHAR(16777216),
    zip_code VARCHAR(16777216),
    phone_number VARCHAR(16777216),
    _loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    _file_name VARCHAR(16777216)
);

-- Raw Facilities Table
CREATE OR REPLACE TABLE raw.facilities (
    facility_id VARCHAR(16777216),
    facility_name VARCHAR(16777216),
    facility_type VARCHAR(16777216),
    npi VARCHAR(16777216),
    tax_id VARCHAR(16777216),
    address_line1 VARCHAR(16777216),
    address_line2 VARCHAR(16777216),
    city VARCHAR(16777216),
    state VARCHAR(16777216),
    zip_code VARCHAR(16777216),
    phone_number VARCHAR(16777216),
    _loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    _file_name VARCHAR(16777216)
);

-- Raw Insurance Plans Table
CREATE OR REPLACE TABLE raw.insurance_plans (
    plan_id VARCHAR(16777216),
    payer_id VARCHAR(16777216),
    payer_name VARCHAR(16777216),
    plan_name VARCHAR(16777216),
    plan_type VARCHAR(16777216),
    group_number VARCHAR(16777216),
    _loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    _file_name VARCHAR(16777216)
);

-- Raw Patient Insurance Table
CREATE OR REPLACE TABLE raw.patient_insurance (
    coverage_id VARCHAR(16777216),
    patient_id VARCHAR(16777216),
    plan_id VARCHAR(16777216),
    member_id VARCHAR(16777216),
    coverage_type VARCHAR(16777216),
    effective_date VARCHAR(16777216),
    termination_date VARCHAR(16777216),
    copay_amount VARCHAR(16777216),
    deductible_amount VARCHAR(16777216),
    out_of_pocket_max VARCHAR(16777216),
    _loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    _file_name VARCHAR(16777216)
);

-- Raw Encounters Table
CREATE OR REPLACE TABLE raw.encounters (
    encounter_id VARCHAR(16777216),
    patient_id VARCHAR(16777216),
    facility_id VARCHAR(16777216),
    encounter_type VARCHAR(16777216),
    admission_date VARCHAR(16777216),
    discharge_date VARCHAR(16777216),
    attending_provider_id VARCHAR(16777216),
    admitting_diagnosis_code VARCHAR(16777216),
    discharge_disposition VARCHAR(16777216),
    _loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    _file_name VARCHAR(16777216)
);

-- Raw Diagnoses Table
CREATE OR REPLACE TABLE raw.diagnoses (
    diagnosis_id VARCHAR(16777216),
    encounter_id VARCHAR(16777216),
    diagnosis_code VARCHAR(16777216),
    diagnosis_type VARCHAR(16777216),
    diagnosis_description VARCHAR(16777216),
    diagnosis_rank VARCHAR(16777216),
    present_on_admission VARCHAR(16777216),
    _loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    _file_name VARCHAR(16777216)
);

-- Raw Procedures Table
CREATE OR REPLACE TABLE raw.procedures (
    procedure_id VARCHAR(16777216),
    encounter_id VARCHAR(16777216),
    procedure_code VARCHAR(16777216),
    procedure_type VARCHAR(16777216),
    procedure_description VARCHAR(16777216),
    procedure_date VARCHAR(16777216),
    performing_provider_id VARCHAR(16777216),
    modifier_1 VARCHAR(16777216),
    modifier_2 VARCHAR(16777216),
    modifier_3 VARCHAR(16777216),
    modifier_4 VARCHAR(16777216),
    _loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    _file_name VARCHAR(16777216)
);

-- Raw Prior Authorizations Table
CREATE OR REPLACE TABLE raw.prior_authorizations (
    auth_id VARCHAR(16777216),
    auth_number VARCHAR(16777216),
    patient_id VARCHAR(16777216),
    plan_id VARCHAR(16777216),
    requesting_provider_id VARCHAR(16777216),
    procedure_code VARCHAR(16777216),
    auth_status VARCHAR(16777216),
    approved_units VARCHAR(16777216),
    effective_date VARCHAR(16777216),
    expiration_date VARCHAR(16777216),
    _loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    _file_name VARCHAR(16777216)
);

-- Raw Claims Table
CREATE OR REPLACE TABLE raw.claims (
    claim_id VARCHAR(16777216),
    claim_number VARCHAR(16777216),
    encounter_id VARCHAR(16777216),
    patient_id VARCHAR(16777216),
    plan_id VARCHAR(16777216),
    claim_type VARCHAR(16777216),
    claim_status VARCHAR(16777216),
    service_date_from VARCHAR(16777216),
    service_date_to VARCHAR(16777216),
    submission_date VARCHAR(16777216),
    billing_provider_id VARCHAR(16777216),
    rendering_provider_id VARCHAR(16777216),
    referring_provider_id VARCHAR(16777216),
    facility_id VARCHAR(16777216),
    auth_id VARCHAR(16777216),
    total_charge_amount VARCHAR(16777216),
    total_allowed_amount VARCHAR(16777216),
    total_paid_amount VARCHAR(16777216),
    patient_responsibility VARCHAR(16777216),
    deductible_amount VARCHAR(16777216),
    copay_amount VARCHAR(16777216),
    coinsurance_amount VARCHAR(16777216),
    primary_payer_claim_id VARCHAR(16777216),
    _loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    _file_name VARCHAR(16777216)
);

-- Raw Claim Line Items Table
CREATE OR REPLACE TABLE raw.claim_line_items (
    line_item_id VARCHAR(16777216),
    claim_id VARCHAR(16777216),
    line_number VARCHAR(16777216),
    procedure_code VARCHAR(16777216),
    procedure_type VARCHAR(16777216),
    procedure_description VARCHAR(16777216),
    modifier_1 VARCHAR(16777216),
    modifier_2 VARCHAR(16777216),
    modifier_3 VARCHAR(16777216),
    modifier_4 VARCHAR(16777216),
    service_date VARCHAR(16777216),
    place_of_service VARCHAR(16777216),
    units VARCHAR(16777216),
    charge_amount VARCHAR(16777216),
    allowed_amount VARCHAR(16777216),
    paid_amount VARCHAR(16777216),
    denial_reason_code VARCHAR(16777216),
    revenue_code VARCHAR(16777216),
    ndc_code VARCHAR(16777216),
    _loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    _file_name VARCHAR(16777216)
);

-- Raw Payments Table
CREATE OR REPLACE TABLE raw.payments (
    payment_id VARCHAR(16777216),
    claim_id VARCHAR(16777216),
    payment_number VARCHAR(16777216),
    payment_date VARCHAR(16777216),
    payment_method VARCHAR(16777216),
    check_eft_number VARCHAR(16777216),
    payment_amount VARCHAR(16777216),
    applied_amount VARCHAR(16777216),
    _loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    _file_name VARCHAR(16777216)
);

-- Raw Payment Adjustments Table
CREATE OR REPLACE TABLE raw.payment_adjustments (
    adjustment_id VARCHAR(16777216),
    payment_id VARCHAR(16777216),
    claim_id VARCHAR(16777216),
    line_item_id VARCHAR(16777216),
    adjustment_code VARCHAR(16777216),
    adjustment_reason VARCHAR(16777216),
    adjustment_amount VARCHAR(16777216),
    adjustment_date VARCHAR(16777216),
    _loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    _file_name VARCHAR(16777216)
);

-- Raw Denials Table
CREATE OR REPLACE TABLE raw.denials (
    denial_id VARCHAR(16777216),
    claim_id VARCHAR(16777216),
    line_item_id VARCHAR(16777216),
    denial_date VARCHAR(16777216),
    denial_code VARCHAR(16777216),
    denial_reason VARCHAR(16777216),
    denial_category VARCHAR(16777216),
    appeal_deadline VARCHAR(16777216),
    appeal_status VARCHAR(16777216),
    _loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    _file_name VARCHAR(16777216)
);

-- Raw Appeals Table
CREATE OR REPLACE TABLE raw.appeals (
    appeal_id VARCHAR(16777216),
    denial_id VARCHAR(16777216),
    claim_id VARCHAR(16777216),
    appeal_level VARCHAR(16777216),
    appeal_date VARCHAR(16777216),
    appeal_reason VARCHAR(16777216),
    appeal_status VARCHAR(16777216),
    appeal_decision_date VARCHAR(16777216),
    appeal_outcome_amount VARCHAR(16777216),
    _loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    _file_name VARCHAR(16777216)
);

-- Raw Coordination of Benefits Table
CREATE OR REPLACE TABLE raw.coordination_of_benefits (
    cob_id VARCHAR(16777216),
    claim_id VARCHAR(16777216),
    patient_id VARCHAR(16777216),
    primary_plan_id VARCHAR(16777216),
    secondary_plan_id VARCHAR(16777216),
    primary_paid_amount VARCHAR(16777216),
    secondary_paid_amount VARCHAR(16777216),
    patient_paid_amount VARCHAR(16777216),
    cob_adjustment_amount VARCHAR(16777216),
    _loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    _file_name VARCHAR(16777216)
);

-- Raw Fee Schedule Table
CREATE OR REPLACE TABLE raw.fee_schedule (
    fee_schedule_id VARCHAR(16777216),
    plan_id VARCHAR(16777216),
    procedure_code VARCHAR(16777216),
    procedure_type VARCHAR(16777216),
    effective_date VARCHAR(16777216),
    termination_date VARCHAR(16777216),
    allowed_amount VARCHAR(16777216),
    relative_value_unit VARCHAR(16777216),
    _loaded_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    _file_name VARCHAR(16777216)
);

-- Create stage for CSV files
CREATE OR REPLACE STAGE raw.csv_stage
    FILE_FORMAT = (
        TYPE = 'CSV'
        FIELD_DELIMITER = ','
        SKIP_HEADER = 1
        NULL_IF = ('NULL', 'null', '')
        EMPTY_FIELD_AS_NULL = TRUE
        FIELD_OPTIONALLY_ENCLOSED_BY = '"'
        ESCAPE_UNENCLOSED_FIELD = NONE
    );

-- Grant permissions to dbt role (adjust role name as needed)
GRANT USAGE ON SCHEMA raw TO ROLE healthcare_demo_admin_role;
GRANT SELECT ON ALL TABLES IN SCHEMA raw TO ROLE healthcare_demo_admin_role;
GRANT INSERT ON ALL TABLES IN SCHEMA raw TO ROLE healthcare_demo_admin_role;
GRANT USAGE ON STAGE raw.csv_stage TO ROLE healthcare_demo_admin_role;

-- Sample COPY commands for loading data
/*
-- Upload files to stage first
PUT file://patients.csv @raw.csv_stage;
PUT file://providers.csv @raw.csv_stage;
-- ... continue for all files

-- Load data into raw tables
COPY INTO raw.patients (patient_id, medical_record_number, first_name, last_name, date_of_birth, 
                        gender, ssn, address_line1, address_line2, city, state, zip_code, 
                        phone_number, email, _file_name)
FROM (SELECT $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, 
             METADATA$FILENAME
      FROM @raw.csv_stage/patients.csv);

COPY INTO raw.providers
FROM @raw.csv_stage/providers.csv
FILE_FORMAT = (FORMAT_NAME = 'raw.csv_stage');

-- Continue for all tables...
*/