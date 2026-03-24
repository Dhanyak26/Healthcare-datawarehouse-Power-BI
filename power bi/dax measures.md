## DAX measures

1. Total Revenue (Completed & Paid)
Total revenue(Completed & paid) = CALCULATE(SUM('gold fact_hospital_events'[amount]), 'gold fact_hospital_events'[appointment_status] = "Completed", 'gold fact_hospital_events'[payment_status] = "Paid")
Purpose:
Calculates total realized revenue from successfully completed and paid appointments.
Business Context:
Used to measure actual revenue contributing to business performance, excluding pending or failed payments.

2. Total Appointments
   
Total Appointments = DISTINCTCOUNT('gold fact_hospital_events'[appointment_id])
Purpose:
Counts the total number of appointments scheduled.
Business Context:
Helps understand overall demand and operational workload of the hospital.

3. Completed Appointments
   
Completed Appointments =CALCULATE(DISTINCTCOUNT('gold fact_hospital_events'[appointment_id]),'gold fact_hospital_events'[appointment_status] = "Completed")
Purpose:
Counts appointments that were successfully completed.
Business Context:
Used to evaluate service delivery efficiency and successful patient handling.

4. Conversion Rate
   
Conversion Rate = DIVIDE([Completed Appointments], CALCULATE( DISTINCTCOUNT('gold fact_hospital_events'[appointment_id]), 'gold fact_hospital_events'[appointment_status] <> "Scheduled” ))
Purpose:
Measures the percentage of appointments that result in successful completion.
Business Context:
Indicates operational effectiveness and patient conversion from scheduled to completed visits.

5. Cancelled Appointments %
   
Cancelled appointments % = DIVIDE(CALCULATE(DISTINCTCOUNT('gold fact_hospital_events'[appointment_id]),'gold fact_hospital_events'[appointment_status] = "Cancelled"), [Total appointments])
Purpose:
Calculates the proportion of appointments that were cancelled.
Business Context:
Helps identify operational inefficiencies or patient drop-offs.

6. No Show Appointments %
   
No show appointments % = DIVIDE(CALCULATE(DISTINCTCOUNT('gold fact_hospital_events'[appointment_id]), 'gold fact_hospital_events'[appointment_status] = "No show"), [Total appointments])
Purpose:
Measures the percentage of patients who did not attend scheduled appointments.
Business Context:
Important for understanding lost revenue opportunities and planning overbooking strategies.

7. Collection Rate
   
Collection rate = DIVIDE([Total revenue(All paid)], [Total payment])
Purpose:
Calculates the percentage of billed revenue that has been successfully collected.
Business Context:
Indicates financial efficiency and effectiveness of the payment collection process.

8. Average Revenue per Appointment
   
Average revenue per appointment = DIVIDE([Total revenue(Completed & paid)], [Completed appointments])
Purpose:
Calculates the average revenue generated per completed appointment.
Business Context:
Helps evaluate revenue efficiency per service delivered.

9. Average Revenue per Patient

Average revenue per patient = DIVIDE([Total revenue(Completed & paid)], [Total patients (Active)])
Purpose:
Measures the average revenue generated per active patient.
Business Context:
Useful for understanding patient value and revenue contribution.

10. Failed Payment %

Failed payment % = DIVIDE([Failed payment],[Total payment])
Purpose:
Calculates the proportion of total payment value that failed.
Business Context:
Helps identify revenue leakage and payment system inefficiencies.

11. Pending Amount
    
Pending amount = CALCULATE(SUM('gold fact_hospital_events'[amount]), 'gold fact_hospital_events'[payment_status] = "Pending")
Purpose:
Calculates total outstanding payment amount.
Business Context:
Used to track unpaid revenue and improve collection strategies.

Used to track unpaid revenue and improve collection strategies.

