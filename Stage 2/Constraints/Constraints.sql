--Make sure that phone numbers start with 0
ALTER TABLE PATIENT
ADD CONSTRAINT check_mobile_patient
CHECK (CMOBILE LIKE '0%');

INSERT INTO Patient (cBirthYear, cAddress, cName, cGender, cId, cMobile, cMail) VALUES (1990, '456 Oak Ave', 'Bob Smith', 'M', 25671, '987654321', 'bob@email.com');

select * from patient

--Make sure treatment price isnt <=0
ALTER TABLE treatment
ADD CONSTRAINT check_price
CHECK (PRICE > 0);

INSERT INTO Treatment (tType, Description, Price, tId, Time) VALUES ('Medication','Antibiotics',-15,60002,0.5);

select * from treatment


--Create a default date for appointments
ALTER TABLE appointment
MODIFY aDate DATE DEFAULT TRUNC(SYSDATE);

INSERT INTO Appointment ( AppointmentID, sId, cId) VALUES ( 39876, 10001, 20001);

select * from appointment
where AppointmentID=39876

--Create a Not Null command
ALTER TABLE staff
MODIFY SNAME VARCHAR2(30) NOT NULL;

INSERT INTO Staff (sAddress, sMobile,sMail, sId) VALUES ('123 Main St', '123456789', 'john@email.com', 10789);

