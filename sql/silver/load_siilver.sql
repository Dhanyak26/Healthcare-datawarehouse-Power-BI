/*
File Name      : load_silver.sql
Layer       : Silver
Purpose     : Clean, standardize, and load data into silver tables.
Description :
- Transforms raw bronze data into structured silver tables.
- Applies data quality rules and basic business logic.
- Produces reliable, analysis-ready datasets.

Notes       :
- Includes type casting, formatting, and basic data cleaning.
- No aggregations are performed at this stage.
- Serves as the foundation for gold-layer modeling.
*/

-- Assumption: bronze tables contain raw but complete source data

-- ============================================
-- Clean and load appointments master data
-- ============================================

INSERT INTO silver.appointments
(
	appointment_id,
	patient_id,
	doctor_id,
	appointment_date,
	appointment_time,
	reason_for_visit,
	status
)
SELECT
	appointment_id,
	patient_id,
	doctor_id,
	CAST(appointment_date AS DATE) AS appointment_date,
	CAST(appointment_time AS TIME) AS appointment_time,
	REPLACE(reason_for_visit,'-',' ')AS reason_for_visit,
	REPLACE(status,'-',' ') AS status
FROM bronze.appointments;

-- ============================================
-- Clean and load billing master data
-- ============================================


INSERT INTO silver.billing
(
	bill_id,
	patient_id,
	treatment_id,
	bill_date,
	amount,
	payment_method,
	payment_status
)
SELECT
	bill_id,
	patient_id,
	treatment_id,
	CAST(bill_date AS DATE) AS bill_date,
	CAST(amount AS DECIMAL(10,2)) AS amount,
	payment_method,
	payment_status
FROM bronze.billing;

-- ============================================
-- Clean and load doctors master data
-- ============================================


INSERT INTO silver.doctors
(
	doctor_id,
	doctor_name,
	specialization,
	phone_number,
	years_experience,
	hospital_branch,
	doctor_email
)
SELECT
	doctor_id,
	first_name + ' ' + last_name AS doctor_name,
	specialization,
	phone_number,
	years_experience,
	hospital_branch,
	LOWER(email) AS doctor_email
FROM bronze.doctors;

-- ============================================
-- Clean and load patients master data
-- ============================================

INSERT INTO silver.patients
(
	patient_id,
	patient_name,
	gender,
	date_of_birth,
	contact_number,
	address,
	registration_date,
	insurance_provider,
	insurance_number,
	patient_email
)
SELECT
	patient_id,
--Combines first and last names
	first_name + ' ' + last_name AS patient_name,
	CASE WHEN gender = 'F' THEN 'Female'
		 WHEN gender = 'M' THEN 'Male'
	END AS gender,
	CAST(date_of_birth AS DATE) AS date_of_birth,
	contact_number,
	address,
	CAST(registration_date AS DATE) AS registration_date,
	REPLACE(insurance_provider,' ','')insurance_provider,
	insurance_number,
	LOWER(email) AS patient_email
FROM bronze.patients;

-- ============================================
-- Clean and load treatments master data
-- ============================================

INSERT INTO silver.treatments
(
	treatment_id,
	appointment_id,
	treatment_type,
	description,
	cost,
	treatment_date
)
SELECT
	treatment_id,
	appointment_id,
	treatment_type,
	description,
	CAST(cost AS DECIMAL(10,2)) AS cost,
	CAST(treatment_date AS DATE) AS treatment_date
FROM bronze.treatments