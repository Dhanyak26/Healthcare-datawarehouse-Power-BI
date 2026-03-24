/*
File Name      : create_bronze.sql
Layer          : Bronze
Purpose        : Create raw staging tables for the healthcare dataset.
Description    :
- This script defines the schema for bronze-layer tables.
- Data is stored in its raw form.
- Used as the first ingestion layer from source CSV files.

Notes          :
- No business logic applied.
- Data quality issues (nulls, duplicates) are handled in later layers.
- Tables are recreated only during initial setup.

*/

--Recreate table to allow repeatable pipeline setup

IF OBJECT_ID ('bronze.appointments', 'U') IS NOT NULL
	DROP TABLE bronze.appointments;

CREATE TABLE bronze.appointments
(
-- Assumption: column data types match source CSV definitions

	appointment_id VARCHAR(20),
	patient_id VARCHAR(20),
	doctor_id VARCHAR(20),
	appointment_date VARCHAR(20),
	appointment_time VARCHAR(20),
	reason_for_visit VARCHAR(20),
	status VARCHAR(20)
);

IF OBJECT_ID ('bronze.billing', 'U') IS NOT NULL
	DROP TABLE bronze.billing;

CREATE TABLE bronze.billing
(
	bill_id VARCHAR(20),
	patient_id VARCHAR(20),
	treatment_id VARCHAR(20),
	bill_date VARCHAR(20),
	amount VARCHAR(20),
	payment_method VARCHAR(20),
	payment_status VARCHAR(20)
);

IF OBJECT_ID ('bronze.doctors', 'U') IS NOT NULL
	DROP TABLE bronze.doctors;

CREATE TABLE bronze.doctors
(
	doctor_id VARCHAR(20),
	first_name VARCHAR(25),
	last_name VARCHAR (25),
	specialization VARCHAR(20),
	phone_number VARCHAR(20),
	years_experience VARCHAR(10),
	hospital_branch VARCHAR(25),
	email VARCHAR(50)
);

IF OBJECT_ID ('bronze.patients', 'U') IS NOT NULL
	DROP TABLE bronze.patients;

CREATE TABLE bronze.patients
(
	patient_id VARCHAR(20),
	first_name VARCHAR(20),
	last_name VARCHAR(20),
	gender VARCHAR(20),
	date_of_birth VARCHAR(20),
	contact_number VARCHAR(20),
	address VARCHAR(MAX),
	registration_date VARCHAR(20),
	insurance_provider VARCHAR(50),
	insurance_number VARCHAR(20),
	email VARCHAR(50)
);

IF OBJECT_ID ('bronze.treatments', 'U') IS NOT NULL
	DROP TABLE bronze.treatments;

CREATE TABLE bronze.treatments
(
	treatment_id VARCHAR(20),
	appointment_id VARCHAR(20),
	treatment_type VARCHAR(50),
	description VARCHAR(50),
	cost VARCHAR(20),
	treatment_date VARCHAR(20)
)