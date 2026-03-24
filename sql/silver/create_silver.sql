/*
File Name   : create_silver.sql
Layer       : Silver
Purpose     : Define cleaned and standardized tables for the healthcare dataset.
Description :
- Creates silver-layer tables derived from bronze data.
- Tables are designed with consistent naming and data types.
- Supports downstream analytical and reporting use cases.

Notes       :
- No aggregations are defined at this stage.
- Business rules and data cleansing are applied during loading.
- Tables are recreated to support repeatable pipeline execution.
- Depends on bronze-layer tables.
*/

IF OBJECT_ID ('silver.appointments', 'U') IS NOT NULL
	DROP TABLE silver.appointments;

CREATE TABLE silver.appointments
(
	appointment_id VARCHAR(20),
	patient_id VARCHAR(20),
	doctor_id VARCHAR(20),
	appointment_date DATE,
	appointment_time TIME(0),
	reason_for_visit VARCHAR(20),
	status VARCHAR(20)
);

IF OBJECT_ID ('silver.billing', 'U') IS NOT NULL
	DROP TABLE silver.billing;

CREATE TABLE silver.billing
(
	bill_id VARCHAR(20),
	patient_id VARCHAR(20),
	treatment_id VARCHAR(20),
	bill_date DATE,
	amount DECIMAL(10,2),
	payment_method VARCHAR(20),
	payment_status VARCHAR(20)
);

IF OBJECT_ID ('silver.doctors', 'U') IS NOT NULL
	DROP TABLE silver.doctors;

CREATE TABLE silver.doctors
(
	doctor_id VARCHAR(20),
	doctor_name VARCHAR (50),
	specialization VARCHAR(20),
	phone_number VARCHAR(15),
	years_experience INT,
	hospital_branch VARCHAR(25),
	doctor_email VARCHAR(50)
);

IF OBJECT_ID ('silver.patients', 'U') IS NOT NULL
	DROP TABLE silver.patients;

CREATE TABLE silver.patients
(
	patient_id VARCHAR(20),
	patient_name VARCHAR(50),
	gender VARCHAR(15),
	date_of_birth DATE,
	contact_number VARCHAR(15),
	address VARCHAR(50),
	registration_date DATE,
	insurance_provider VARCHAR(25),
	insurance_number VARCHAR(20),
	patient_email VARCHAR(50)
);

IF OBJECT_ID ('silver.treatments', 'U') IS NOT NULL
	DROP TABLE silver.treatments;

CREATE TABLE silver.treatments
(
	treatment_id VARCHAR(20),
	appointment_id VARCHAR(20),
	treatment_type VARCHAR(25),
	description VARCHAR(35),
	cost DECIMAL(10,2),
	treatment_date DATE
)