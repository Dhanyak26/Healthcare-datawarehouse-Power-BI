/*
File Name   : load_GOLD.sql
Layer       : Gold
Purpose     : Populate Gold layer dimension and fact tables.
Description :
- Loads transformed data from the Silver layer into Gold tables.
- Applies business logic, aggregations, and derived metrics.
- Produces final datasets for dashboards and analytical queries.

Notes       :
- Assumes Silver layer data is cleaned and standardized.
- Execution order matters due to table dependencies.
- Final output layer of the data pipeline.
*/
INSERT INTO gold.dim_patients
(
	patient_id,
	patient_name,
	gender,
	date_of_birth,
	age,
	registration_date,
	insurance_provider
)
SELECT
	patient_id,
	patient_name,
	gender,
	date_of_birth,
	DATEDIFF(YEAR, date_of_birth, GETDATE()) - CASE
		WHEN DATEADD(YEAR, DATEDIFF(YEAR, date_of_birth, GETDATE()), date_of_birth) > GETDATE() THEN 1
		ELSE 0
		END AS age,
	registration_date,
	insurance_provider
FROM silver.patients;

INSERT INTO gold.dim_doctors
(
	doctor_id,
	doctor_name,
	specialization,
	years_experience,
	hospital_branch
)
SELECT
	doctor_id,
	doctor_name,
	specialization,
	years_experience,
	hospital_branch
FROM silver.doctors

-- Generate date dimension dynamically using recursive CTE

DECLARE @start_date DATE, @end_date DATE;
SELECT
	@start_date = MIN(dt),
	@end_date = MAX(dt)
FROM
(
	SELECT
		appointment_date AS dt
	FROM silver.appointments
	UNION
	SELECT
		treatment_date
	FROM silver.treatments
	UNION
	SELECT
		bill_date
	FROM silver.billing
)d;

;WITH calender AS
(
	SELECT @start_date AS full_date
	UNION ALL
	SELECT DATEADD(DAY,1,full_date)
	FROM calender 
	WHERE full_date < @end_date
)

INSERT INTO gold.dim_date
(
	date_key,
	full_date,
	year,
	month,
	month_name,
	quarter,
	day_of_week
)
SELECT
	CONVERT(INT, FORMAT(full_date,'yyMMdd')) AS date_key,
	full_date,
	YEAR(full_date) AS year,
	MONTH(full_date) AS month,
	DATENAME(MONTH,full_date) AS month_name,
	DATEPART(QUARTER, full_date) AS quarter,
	DATENAME(WEEKDAY,full_date) AS day_of_week
FROM calender
OPTION (MAXRECURSION 0);

INSERT INTO gold.dim_treatment_type
(
	treatment_type
)
SELECT DISTINCT
	treatment_type
FROM silver.treatments;

INSERT INTO gold.dim_payment_method
(
	payment_method
)
SELECT DISTINCT
	payment_method
FROM silver.billing;

INSERT INTO gold.dim_reason_for_visit
(
	reason_for_visit
)
SELECT DISTINCT
	reason_for_visit
FROM silver.appointments;

INSERT INTO gold.fact_hospital_events
(
	appointment_id,
	patient_key,
	doctor_key,
	appointment_date_key,
	appointment_time,
	reason_for_visit_key, 
	appointment_status,
	treatment_id,
	treatment_type_key,
	treatment_date_key,
	bill_id,
	bill_date_key,
	amount,
	payment_method_key,
	payment_status
)

SELECT
	a.appointment_id,
	p.patient_key,
	d.doctor_key,
	CONVERT(INT, FORMAT(a.appointment_date,'yyMMdd')) AS appointment_date_key,
	a.appointment_time,
	r.reason_for_visit_key, 
	a.status AS appointment_status,
	t.treatment_id,
	tt.treatment_type_key,
	CONVERT(INT, FORMAT(t.treatment_date,'yyMMdd')) AS treatment_date_key,
	b.bill_id,
	CONVERT(INT, FORMAT(b.bill_date,'yyMMdd')) AS bill_date_key,
	b.amount,
	pm.payment_method_key,
	b.payment_status
FROM silver.appointments a
LEFT JOIN gold.dim_patients p
ON p.patient_id = a.patient_id
LEFT JOIN gold.dim_doctors d
ON d.doctor_id = a.doctor_id
LEFT JOIN gold.dim_reason_for_visit r
ON r.reason_for_visit = a.reason_for_visit
LEFT JOIN silver.treatments t
ON t.appointment_id = a.appointment_id
LEFT JOIN gold.dim_treatment_type tt
ON tt.treatment_type = t.treatment_type
LEFT JOIN silver.billing b
ON b.treatment_id = t.treatment_id
LEFT JOIN gold.dim_payment_method pm
ON pm.payment_method = b.payment_method
