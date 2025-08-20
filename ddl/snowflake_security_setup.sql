-- Snowflake Security Setup for Healthcare Claims Database
-- Run this script with ACCOUNTADMIN or SECURITYADMIN role

-- ============================================
-- 1. CREATE DATABASE AND WAREHOUSE
-- ============================================

USE ROLE SECURITYADMIN;

-- Create warehouse for demo users
CREATE WAREHOUSE IF NOT EXISTS healthcare_demo_wh
    WAREHOUSE_SIZE = 'SMALL'
    AUTO_SUSPEND = 300  -- 5 minutes
    AUTO_RESUME = TRUE
    MIN_CLUSTER_COUNT = 1
    MAX_CLUSTER_COUNT = 2
    SCALING_POLICY = 'STANDARD'
    COMMENT = 'Warehouse for healthcare claims demo and analysis';

-- ============================================
-- 2. CREATE ROLES
-- ============================================

-- Read-only analyst role
CREATE ROLE IF NOT EXISTS healthcare_analyst_role
    COMMENT = 'Read-only access to healthcare claims data and views';

-- Power analyst role with ability to create temp tables
CREATE ROLE IF NOT EXISTS healthcare_power_analyst_role
    COMMENT = 'Read access plus ability to create temporary objects for analysis';

-- Report writer role for creating/managing views
CREATE ROLE IF NOT EXISTS healthcare_report_writer_role
    COMMENT = 'Can create and manage views and stored procedures';

-- Data steward role for data quality monitoring
CREATE ROLE IF NOT EXISTS healthcare_data_steward_role
    COMMENT = 'Monitor data quality and audit access';

-- Demo admin role for managing demo environment
CREATE ROLE IF NOT EXISTS healthcare_demo_admin_role
    COMMENT = 'Administer the healthcare demo environment';

-- ============================================
-- 3. CREATE ROLE HIERARCHY
-- ============================================

-- Establish role inheritance
GRANT ROLE healthcare_analyst_role TO ROLE healthcare_power_analyst_role;
GRANT ROLE healthcare_power_analyst_role TO ROLE healthcare_report_writer_role;
GRANT ROLE healthcare_report_writer_role TO ROLE healthcare_demo_admin_role;
GRANT ROLE healthcare_data_steward_role TO ROLE healthcare_demo_admin_role;

-- Grant demo admin role to sysadmin for management
GRANT ROLE healthcare_demo_admin_role TO ROLE SYSADMIN;

-- ============================================
-- 4. GRANT WAREHOUSE USAGE
-- ============================================

-- All roles can use the demo warehouse
GRANT USAGE ON WAREHOUSE healthcare_demo_wh TO ROLE healthcare_analyst_role;
GRANT USAGE ON WAREHOUSE healthcare_demo_wh TO ROLE healthcare_power_analyst_role;
GRANT USAGE ON WAREHOUSE healthcare_demo_wh TO ROLE healthcare_report_writer_role;
GRANT USAGE ON WAREHOUSE healthcare_demo_wh TO ROLE healthcare_data_steward_role;
GRANT USAGE ON WAREHOUSE healthcare_demo_wh TO ROLE healthcare_demo_admin_role;

-- Power analysts and above can modify warehouse settings
GRANT OPERATE ON WAREHOUSE healthcare_demo_wh TO ROLE healthcare_power_analyst_role;

-- ============================================
-- 5. GRANT DATABASE AND SCHEMA PRIVILEGES
-- ============================================

-- Assuming database already exists, if not uncomment:
-- CREATE DATABASE IF NOT EXISTS healthcare_db;
-- CREATE SCHEMA IF NOT EXISTS healthcare_db.healthcare;

-- Grant database usage to all roles
GRANT USAGE ON DATABASE healthcare_db TO ROLE healthcare_analyst_role;
GRANT USAGE ON DATABASE healthcare_db TO ROLE healthcare_power_analyst_role;
GRANT USAGE ON DATABASE healthcare_db TO ROLE healthcare_report_writer_role;
GRANT USAGE ON DATABASE healthcare_db TO ROLE healthcare_data_steward_role;
GRANT USAGE ON DATABASE healthcare_db TO ROLE healthcare_demo_admin_role;

-- Grant schema usage
GRANT USAGE ON SCHEMA healthcare_db.healthcare TO ROLE healthcare_analyst_role;
GRANT USAGE ON SCHEMA healthcare_db.healthcare TO ROLE healthcare_power_analyst_role;
GRANT USAGE ON SCHEMA healthcare_db.healthcare TO ROLE healthcare_report_writer_role;
GRANT USAGE ON SCHEMA healthcare_db.healthcare TO ROLE healthcare_data_steward_role;
GRANT USAGE ON SCHEMA healthcare_db.healthcare TO ROLE healthcare_demo_admin_role;

-- ============================================
-- 6. GRANT TABLE AND VIEW PRIVILEGES
-- ============================================

-- Analyst role: read-only access to tables and views
GRANT SELECT ON ALL TABLES IN SCHEMA healthcare_db.healthcare TO ROLE healthcare_analyst_role;
GRANT SELECT ON ALL VIEWS IN SCHEMA healthcare_db.healthcare TO ROLE healthcare_analyst_role;
GRANT SELECT ON FUTURE TABLES IN SCHEMA healthcare_db.healthcare TO ROLE healthcare_analyst_role;
GRANT SELECT ON FUTURE VIEWS IN SCHEMA healthcare_db.healthcare TO ROLE healthcare_analyst_role;

-- Power analyst: can create temp tables in schema
GRANT CREATE TABLE ON SCHEMA healthcare_db.healthcare TO ROLE healthcare_power_analyst_role;
GRANT CREATE VIEW ON SCHEMA healthcare_db.healthcare TO ROLE healthcare_power_analyst_role;

-- Report writer: can create permanent views and procedures
GRANT CREATE VIEW ON SCHEMA healthcare_db.healthcare TO ROLE healthcare_report_writer_role;
GRANT CREATE PROCEDURE ON SCHEMA healthcare_db.healthcare TO ROLE healthcare_report_writer_role;
GRANT CREATE FUNCTION ON SCHEMA healthcare_db.healthcare TO ROLE healthcare_report_writer_role;

-- Data steward: monitor and audit capabilities
GRANT MONITOR ON SCHEMA healthcare_db.healthcare TO ROLE healthcare_data_steward_role;
GRANT SELECT ON ALL TABLES IN SCHEMA healthcare_db.healthcare TO ROLE healthcare_data_steward_role;
GRANT SELECT ON ALL VIEWS IN SCHEMA healthcare_db.healthcare TO ROLE healthcare_data_steward_role;

-- Demo admin: full control
GRANT ALL PRIVILEGES ON SCHEMA healthcare_db.healthcare TO ROLE healthcare_demo_admin_role;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA healthcare_db.healthcare TO ROLE healthcare_demo_admin_role;
GRANT ALL PRIVILEGES ON ALL VIEWS IN SCHEMA healthcare_db.healthcare TO ROLE healthcare_demo_admin_role;
GRANT ALL PRIVILEGES ON FUTURE TABLES IN SCHEMA healthcare_db.healthcare TO ROLE healthcare_demo_admin_role;
GRANT ALL PRIVILEGES ON FUTURE VIEWS IN SCHEMA healthcare_db.healthcare TO ROLE healthcare_demo_admin_role;

-- ============================================
-- 7. CREATE DEMO USERS
-- ============================================

-- Create standard analyst user
CREATE USER IF NOT EXISTS demo_analyst_1
    PASSWORD = 'TempPass123!'
    DEFAULT_ROLE = healthcare_analyst_role
    DEFAULT_WAREHOUSE = healthcare_demo_wh
    DEFAULT_NAMESPACE = healthcare_db.healthcare
    MUST_CHANGE_PASSWORD = FALSE
    COMMENT = 'Demo business analyst user 1';

CREATE USER IF NOT EXISTS demo_analyst_2
    PASSWORD = 'TempPass123!'
    DEFAULT_ROLE = healthcare_analyst_role
    DEFAULT_WAREHOUSE = healthcare_demo_wh
    DEFAULT_NAMESPACE = healthcare_db.healthcare
    MUST_CHANGE_PASSWORD = FALSE
    COMMENT = 'Demo business analyst user 2';

-- Create power analyst user
CREATE USER IF NOT EXISTS demo_power_analyst
    PASSWORD = 'TempPass123!'
    DEFAULT_ROLE = healthcare_power_analyst_role
    DEFAULT_WAREHOUSE = healthcare_demo_wh
    DEFAULT_NAMESPACE = healthcare_db.healthcare
    MUST_CHANGE_PASSWORD = FALSE
    COMMENT = 'Demo power analyst with temp table privileges';

-- Create report writer user
CREATE USER IF NOT EXISTS demo_report_writer
    PASSWORD = 'TempPass123!'
    DEFAULT_ROLE = healthcare_report_writer_role
    DEFAULT_WAREHOUSE = healthcare_demo_wh
    DEFAULT_NAMESPACE = healthcare_db.healthcare
    MUST_CHANGE_PASSWORD = FALSE
    COMMENT = 'Demo report developer';

-- Create data steward user
CREATE USER IF NOT EXISTS demo_data_steward
    PASSWORD = 'TempPass123!'
    DEFAULT_ROLE = healthcare_data_steward_role
    DEFAULT_WAREHOUSE = healthcare_demo_wh
    DEFAULT_NAMESPACE = healthcare_db.healthcare
    MUST_CHANGE_PASSWORD = FALSE
    COMMENT = 'Demo data quality monitor';

-- Create demo admin user
CREATE USER IF NOT EXISTS demo_admin
    PASSWORD = 'TempPass123!'
    DEFAULT_ROLE = healthcare_demo_admin_role
    DEFAULT_WAREHOUSE = healthcare_demo_wh
    DEFAULT_NAMESPACE = healthcare_db.healthcare
    MUST_CHANGE_PASSWORD = FALSE
    COMMENT = 'Demo environment administrator';

-- ============================================
-- 8. GRANT ROLES TO USERS
-- ============================================

-- Grant roles to users
GRANT ROLE healthcare_analyst_role TO USER demo_analyst_1;
GRANT ROLE healthcare_analyst_role TO USER demo_analyst_2;
GRANT ROLE healthcare_power_analyst_role TO USER demo_power_analyst;
GRANT ROLE healthcare_report_writer_role TO USER demo_report_writer;
GRANT ROLE healthcare_data_steward_role TO USER demo_data_steward;
GRANT ROLE healthcare_demo_admin_role TO USER demo_admin;

-- Also grant analyst role to power users for flexibility
GRANT ROLE healthcare_analyst_role TO USER demo_power_analyst;
GRANT ROLE healthcare_analyst_role TO USER demo_report_writer;

-- ============================================
-- 9. CREATE RESOURCE MONITORS (Optional)
-- ============================================

USE ROLE ACCOUNTADMIN;

-- Create resource monitor to control costs
CREATE RESOURCE MONITOR IF NOT EXISTS healthcare_demo_monitor
    WITH CREDIT_QUOTA = 100  -- 100 credits per month
    FREQUENCY = MONTHLY
    START_TIMESTAMP = IMMEDIATELY
    TRIGGERS
        ON 75 PERCENT DO NOTIFY
        ON 90 PERCENT DO NOTIFY
        ON 100 PERCENT DO SUSPEND;

-- Assign monitor to warehouse
ALTER WAREHOUSE healthcare_demo_wh SET RESOURCE_MONITOR = healthcare_demo_monitor;

-- ============================================
-- 10. CREATE AUDIT TABLE FOR TRACKING
-- ============================================

USE ROLE healthcare_demo_admin_role;
USE DATABASE healthcare_db;
USE SCHEMA healthcare;

-- Create audit table for demo usage
CREATE TABLE IF NOT EXISTS demo_audit_log (
    audit_id NUMBER AUTOINCREMENT,
    user_name VARCHAR(100),
    role_name VARCHAR(100),
    query_text TEXT,
    query_type VARCHAR(50),
    execution_time TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    warehouse_name VARCHAR(100),
    credits_used FLOAT,
    rows_produced NUMBER,
    error_message TEXT
);

-- Grant read access to data steward for monitoring
GRANT SELECT ON TABLE demo_audit_log TO ROLE healthcare_data_steward_role;

-- ============================================
-- 11. SETUP HELPER STORED PROCEDURES
-- ============================================

-- Create procedure to grant new user access
CREATE OR REPLACE PROCEDURE grant_demo_access(
    username VARCHAR,
    role_type VARCHAR DEFAULT 'analyst'
)
RETURNS VARCHAR
LANGUAGE SQL
EXECUTE AS OWNER
AS
$$
DECLARE
    result VARCHAR;
    role_to_grant VARCHAR;
BEGIN
    -- Determine role based on type
    CASE LOWER(role_type)
        WHEN 'analyst' THEN role_to_grant := 'healthcare_analyst_role';
        WHEN 'power' THEN role_to_grant := 'healthcare_power_analyst_role';
        WHEN 'writer' THEN role_to_grant := 'healthcare_report_writer_role';
        WHEN 'steward' THEN role_to_grant := 'healthcare_data_steward_role';
        WHEN 'admin' THEN role_to_grant := 'healthcare_demo_admin_role';
        ELSE role_to_grant := 'healthcare_analyst_role';
    END CASE;
    
    -- Create user if doesn't exist
    EXECUTE IMMEDIATE 'CREATE USER IF NOT EXISTS ' || username || 
        ' PASSWORD = ''TempPass123!'' MUST_CHANGE_PASSWORD = FALSE ' ||
        ' DEFAULT_ROLE = ' || role_to_grant ||
        ' DEFAULT_WAREHOUSE = healthcare_demo_wh ' ||
        ' DEFAULT_NAMESPACE = healthcare_db.healthcare';
    
    -- Grant role
    EXECUTE IMMEDIATE 'GRANT ROLE ' || role_to_grant || ' TO USER ' || username;
    
    result := 'User ' || username || ' created with role ' || role_to_grant;
    RETURN result;
END;
$$;

-- ============================================
-- 12. VERIFY SETUP
-- ============================================

-- Show created roles
SHOW ROLES LIKE 'healthcare%';

-- Show created users
SHOW USERS LIKE 'demo%';

-- Show grants on analyst role
SHOW GRANTS TO ROLE healthcare_analyst_role;

-- Show grants on power analyst role  
SHOW GRANTS TO ROLE healthcare_power_analyst_role;

-- ============================================
-- 13. USAGE INSTRUCTIONS
-- ============================================

/*
DEMO USER CREDENTIALS AND ACCESS LEVELS:
=========================================

1. demo_analyst_1 / demo_analyst_2 (Password: TempPass123!)
   - Read-only access to all tables and views
   - Can run SELECT queries and analyze data
   - Cannot create or modify objects

2. demo_power_analyst (Password: TempPass123!)
   - All analyst privileges plus:
   - Can create temporary tables for complex analysis
   - Can create personal views

3. demo_report_writer (Password: TempPass123!)
   - All power analyst privileges plus:
   - Can create permanent views
   - Can create stored procedures and functions

4. demo_data_steward (Password: TempPass123!)
   - Monitor data quality
   - View audit logs
   - Cannot modify data

5. demo_admin (Password: TempPass123!)
   - Full control over demo environment
   - Can create new users and grant access
   - Can modify all objects

LOGIN INSTRUCTIONS:
==================
Users can login immediately with the provided credentials.
No password change required for demo environment.

TO ADD NEW DEMO USERS:
=====================
CALL grant_demo_access('new_username', 'analyst');
-- role_type options: 'analyst', 'power', 'writer', 'steward', 'admin'

TO REMOVE DEMO ACCESS:
=====================
DROP USER IF EXISTS username;

TO RESET USER PASSWORD:
======================
ALTER USER username SET PASSWORD = 'NewTempPass123!' MUST_CHANGE_PASSWORD = FALSE;
*/