ALTER TABLE Payment
ADD PaymentType VARCHAR2(20) CONSTRAINT CK_PaymentType CHECK (PaymentType IN ('School', 'Appointment'))
ADD Student_ID NUMBER(5)
MODIFY AppointmentID NUMBER(5) NULL;

-- Add a foreign key for Student_ID
ALTER TABLE Payment
ADD CONSTRAINT FK_Payment_Student
FOREIGN KEY (Student_ID) REFERENCES Student(cid);

-- all the  existing records are payments for appointments
UPDATE Payment
SET PaymentType = 'Appointment'
WHERE AppointmentID IS NOT NULL;

-- Modify the constraint to allow for non-student appointment payments
ALTER TABLE Payment
ADD CONSTRAINT CK_Payment_Type
CHECK (
  (PaymentType = 'School' AND Student_ID IS NOT NULL AND AppointmentID IS NULL) OR
  (PaymentType = 'Appointment' AND AppointmentID IS NOT NULL)
);

select * from payment
