# Healthcare Data Warehouse & Power BI Dashboard

## Project Overview
This project demonstrates an end-to-end healthcare analytics solution using SQL and Power BI.

The data warehouse was built using the Medallion Architecture (Bronze, Silver, Gold layers) to transform raw healthcare data into business-ready insights.  
The final data is visualized through interactive Power BI dashboards for decision-making.

## Architecture

# Bronze Layer (Raw Data)
- Stores raw data from source systems
- No transformations applied
- Used for traceability and auditing

# Silver Layer (Cleaned Data)
- Data cleaning and standardization
- Preparing structured data for analysis

# Gold Layer (Business Data)
- Aggregated and business-ready data
- Used for reporting and dashboards

## Data Model

- The analytics layer is designed using a star schema to support efficient reporting and DAX calculations in power BI.

## Power BI Dashboard

The power BI dashboard is built on top of the gold layer and it has the following pages:
1) Hospital overview
2) Doctors performance
3) Patient insights
4) Billing analysis

The dashboard provides insights on:

- Total revenue and revenue trends
- Doctor performance analysis
- Patient behavior and repeat visits
- Appointment status (completed, cancelled, no-show)
- Payment analysis (paid, pending, failed)

##  Tools & Technologies

- SQL (Data Warehouse Design & Transformation)
- Power BI (Data Visualization & Dashboard)
- CSV (Data Source)

## Key Insights

- Identified top-performing doctors based on treatments and revenue
- Analyzed patient conversion rates and repeat visits
- Tracked revenue leakage through pending and failed payments
- Highlighted appointment trends and no-show patterns


- Improve data validation and error handling
