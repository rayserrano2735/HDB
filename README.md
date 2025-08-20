# Healthcare Claims Database Demo

A comprehensive healthcare claims processing database for Snowflake, complete with sample data, ETL pipelines, and business intelligence views.

## 🎯 Overview

This repository provides a production-ready healthcare claims data model with:
- 17 interconnected tables covering the complete claims lifecycle
- 100 sample claims with ~400 line items
- 15 pre-built analytical views for common reports
- Role-based security model
- dbt-ready ETL pipeline
- Comprehensive documentation

## 📋 Prerequisites

- Snowflake account (Enterprise Edition recommended)
- ACCOUNTADMIN or SECURITYADMIN privileges
- 100 credits allocated for demo environment
- (Optional) dbt Cloud/Core for ETL pipeline

## 🚀 Quick Start

```sql
-- 1. Security Setup (5 min)
-- Run as ACCOUNTADMIN
@scripts/01_security_setup.sql

-- 2. Create Database Schema (2 min)
-- Run as SYSADMIN
@scripts/02_healthcare_ddl.sql

-- 3. Load Sample Data (5 min)
-- Run as healthcare_demo_admin_role
@scripts/03_sample_data.sql

-- 4. Create Reporting Views (2 min)
@scripts/04_reporting_views.sql
```

## 📁 Repository Structure

```
healthcare-claims-db/
├── scripts/
│   ├── 01_security_setup.sql       # Roles, users, warehouse
│   ├── 02_healthcare_ddl.sql       # Main schema creation
│   ├── 02a_raw_schema_ddl.sql      # Optional RAW landing zone
│   ├── 03_sample_data.sql          # 100 claims sample data
│   └── 04_reporting_views.sql      # 15 analytical views
├── data/
│   ├── patients.csv                # 20 patient records
│   ├── claims.csv                   # 100 claim headers
│   └── ...                          # 17 CSV files total
├── dbt/
│   ├── models/
│   │   ├── staging/                # RAW to staging transforms
│   │   └── marts/                   # Business logic models
│   └── dbt_project.yml
├── docs/
│   ├── dba_installation_guide.md   # DBA setup instructions
│   ├── business_analyst_guide.md   # End-user documentation
│   └── data_dictionary.md          # Complete column definitions
└── README.md                        # This file
```

## 🏗️ Architecture

### Data Model
The database is organized into 6 logical sub-models:

| Sub-Model | Tables | Purpose |
|-----------|--------|---------|
| Patient Management | patient, patient_insurance, insurance_plan | Demographics & coverage |
| Provider Network | provider, facility, fee_schedule | Healthcare delivery network |
| Clinical/Medical | encounter, diagnosis, procedure, prior_authorization | Medical events |
| Claims Processing | claim, claim_line_item | Billing transactions |
| Financial/Payment | payment, payment_adjustment, coordination_of_benefits | Reimbursements |
| Denial & Appeals | denial, appeal | Exception handling |

### Loading Options

#### Option A: Direct Load (Quick Demo)
```
SQL Scripts → Healthcare Schema → Reports
```

#### Option B: ETL Pipeline (Production Pattern)
```
CSV Files → RAW Schema → dbt → Healthcare Schema → Reports
```

## 👥 User Roles & Access

| Username | Password | Role | Access Level |
|----------|----------|------|--------------|
| demo_analyst_1 | TempPass123! | healthcare_analyst_role | Read-only |
| demo_analyst_2 | TempPass123! | healthcare_analyst_role | Read-only |
| demo_power_analyst | TempPass123! | healthcare_power_analyst_role | + Temp tables |
| demo_report_writer | TempPass123! | healthcare_report_writer_role | + Create views |
| demo_data_steward | TempPass123! | healthcare_data_steward_role | Data quality monitoring |
| demo_admin | TempPass123! | healthcare_demo_admin_role | Full admin |

## 📊 Key Reports Available

- **Financial**: Claims summary dashboard, revenue cycle KPIs
- **Operational**: Claims aging, processing status
- **Clinical**: Diagnosis analysis, procedure profitability
- **Denial Management**: Denial trends, appeal success rates
- **Provider/Payer**: Performance scorecards, payment velocity

## 🔧 Installation

### Full Installation (~15 minutes)

1. **Clone Repository**
```bash
git clone https://github.com/yourorg/healthcare-claims-db.git
cd healthcare-claims-db
```

2. **Run Security Setup**
```sql
-- In Snowflake, as ACCOUNTADMIN
!source scripts/01_security_setup.sql
```

3. **Create Schemas**
```sql
-- As SYSADMIN
!source scripts/02_healthcare_ddl.sql
!source scripts/02a_raw_schema_ddl.sql  -- Optional for ETL
```

4. **Load Data** (choose one)
```sql
-- Option A: Direct load
!source scripts/03_sample_data.sql

-- Option B: CSV upload
PUT file://data/*.csv @raw.csv_stage;
-- Then run dbt
```

5. **Create Views**
```sql
!source scripts/04_reporting_views.sql
```

### Verification
```sql
-- Check installation
SELECT 'Claims' as entity, COUNT(*) FROM healthcare.claim
UNION ALL
SELECT 'Payments', COUNT(*) FROM healthcare.payment;
-- Expected: 100 claims, ~70 payments
```

## 🧪 Testing

```sql
-- Test user access
USE ROLE healthcare_analyst_role;
SELECT * FROM healthcare.v_claims_summary_dashboard;

-- Test data quality
SELECT * FROM healthcare.v_claims_aging;
```

## 📈 Sample Queries

```sql
-- Monthly revenue trend
SELECT 
    DATE_TRUNC('month', submission_date) as month,
    SUM(total_charge_amount) as charges,
    SUM(total_paid_amount) as payments
FROM healthcare.claim
GROUP BY 1
ORDER BY 1;

-- Denial rate by payer
SELECT 
    payer_name,
    denial_rate_pct
FROM healthcare.v_payer_performance
ORDER BY denial_rate_pct DESC;
```

## 🛠️ Customization

### Adding More Sample Data
Edit CSV files in `/data` directory maintaining foreign key relationships.

### Modifying Views
Views are in `scripts/04_reporting_views.sql`. Add custom views:
```sql
CREATE VIEW v_custom_metric AS
SELECT ...
```

### Adjusting Security
Modify roles in `scripts/01_security_setup.sql`.

## 📚 Documentation

- [DBA Installation Guide](docs/dba_installation_guide.md) - Technical setup
- [Business Analyst Guide](docs/business_analyst_guide.md) - Using the database
- [Data Dictionary](docs/data_dictionary.md) - Complete field definitions

## ⚠️ Important Notes

- Demo environment limited to 100 credits/month via resource monitor
- All demo passwords are set to `TempPass123!` (no change required)
- Sample data covers Nov 2024 - Jan 2025 service dates
- PHI/PII in sample data is synthetic

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/NewReport`)
3. Commit changes (`git commit -m 'Add new denial report'`)
4. Push to branch (`git push origin feature/NewReport`)
5. Open Pull Request

## 📄 License

This project is licensed under the MIT License - see LICENSE file for details.

## 🆘 Support

- **Issues**: Open a GitHub issue
- **Questions**: See documentation in `/docs`
- **Contact**: your-email@company.com

## 🏥 Use Cases

Perfect for:
- Healthcare analytics demos
- Revenue cycle management POCs
- Claims processing training
- dbt/Snowflake workshops
- Data engineering interviews

---
**Version**: 1.0.0  
**Last Updated**: January 2025  
**Snowflake Compatible**: ✅