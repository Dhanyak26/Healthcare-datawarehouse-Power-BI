/*
File Name   : create_gold.sql
Layer       : Gold
Purpose     : Define analytics-ready dimension and fact tables.
Description :
- Creates Gold layer tables modeled for reporting and BI consumption.
- Includes dimension tables for descriptive attributes and fact tables for metrics.
- Tables follow star-schema design principles.

Notes       :
- Data is sourced from the Silver layer.
- Tables are recreated to support repeatable pipeline execution.
- No data is loaded in this script.
*/

IF OBJECT_ID('gold.dim_patients','U') IS NOT NULL
	DROP TABLE gold.dim_patients;

CREATE TABLE gold.dim_patients
(
	patient_key INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	patient_id VARCHAR(20),
	patient_name VARCHAR(50),
	gender VARCHAR(15),
	date_of_birth DATE,
	age INT,
	registration_date DATE,
	insurance_provider VARCHAR(25)
);

IF OBJECT_ID('gold.dim_doctors','U') IS NOT NULL
	DROP TABLE gold.dim_doctors;

CREATE TABLE gold.dim_doctors
(
	doctor_key INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	doctor_id VARCHAR(20),
	doctor_name VARCHAR (50),
	specialization VARCHAR(20),
	years_experience INT,
	hospital_branch VARCHAR(25)
);

IF OBJECT_ID('gold.dim_date','U') IS NOT NULL
	DROP TABLE gold.dim_date;

CREATE TABLE gold.dim_date
(
	date_key INT,
	full_date DATE,
	year INT,
	month INT,
	month_name VARCHAR(20),
	quarter INT,
	day_of_week VARCHAR(20)
);

IF OBJECT_ID('gold.dim_treatment_type','U') IS NOT NULL
	DROP TABLE gold.dim_treatment_type;

CREATE TABLE gold.dim_treatment_type
(
	treatment_type_key INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	treatment_type VARCHAR(25)
);

IF OBJECT_ID('gold.dim_payment_method','U') IS NOT NULL
	DROP TABLE gold.dim_payment_method;

CREATE TABLE gold.dim_payment_method
(
	payment_method_key INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	payment_method VARCHAR(20)
);

IF OBJECT_ID('gold.dim_reason_for_visit','U') IS NOT NULL
	DROP TABLE gold.dim_reason_for_visit;

CREATE TABLE gold.dim_reason_for_visit
(
	reason_for_visit_key INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	reason_for_visit VARCHAR(20)
);

IF OBJECT_ID('gold.fact_hospital_events','U') IS NOT NULL
	DROP TABLE gold.fact_hospital_events;

CREATE TABLE gold.fact_hospital_events
(
	appointment_id VARCHAR(20),
	patient_key INT,
	doctor_key INT,
	appointment_date_key INT,
	appointment_time TIME(0),
	reason_for_visit_key INT, 
	appointment_status VARCHAR(20),
	treatment_id VARCHAR(20),
	treatment_type_key INT,
	treatment_date_key INT,
	bill_id VARCHAR(20),
	bill_date_key INT,
	amount DECIMAL(10,2),
	payment_method_key INT,
	payment_status VARCHAR(20)
)
