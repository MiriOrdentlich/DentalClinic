-- Insert data into Staff table
INSERT INTO Staff (sAddress, sMobile, sName, sMail, sId) VALUES ('123 Main St', '123456789', 'John Doe', 'john@email.com', 10001);
INSERT INTO Staff (sAddress, sMobile, sName, sMail, sId) VALUES ('456 Oak Ave', '987654321', 'Jane Smith', 'jane@email.com', 10002);
INSERT INTO Staff (sAddress, sMobile, sName, sMail, sId) VALUES ('789 Elm St', '456789012', 'Michael Johnson', 'michael@email.com', 10003);
INSERT INTO Staff (sAddress, sMobile, sName, sMail, sId) VALUES ('321 Pine Rd', '789012345', 'Emily Davis', 'emily@email.com', 10004);
INSERT INTO Staff (sAddress, sMobile, sName, sMail, sId) VALUES ('654 Maple Ln', '345678901', 'David Wilson', 'david@email.com', 10005);
INSERT INTO Staff (sAddress, sMobile, sName, sMail, sId) VALUES ('987 Cedar Blvd', '678901234', 'Sarah Thompson', 'sarah@email.com', 10006);
INSERT INTO Staff (sAddress, sMobile, sName, sMail, sId) VALUES ('246 Oak Ct', '901234567', 'Robert Anderson', 'robert@email.com', 10007);
INSERT INTO Staff (sAddress, sMobile, sName, sMail, sId) VALUES ('579 Elm Way', '234567890', 'Jessica Taylor', 'jessica@email.com', 10008);
INSERT INTO Staff (sAddress, sMobile, sName, sMail, sId) VALUES ('813 Pine Ave', '567890123', 'Chris Brown', 'chris@email.com', 10009);
INSERT INTO Staff (sAddress, sMobile, sName, sMail, sId) VALUES ('159 Maple St', '890123456', 'Amanda Garcia', 'amanda@email.com', 10010);
INSERT INTO Staff (sAddress, sMobile, sName, sMail, sId) VALUES ('101 Birch St', '234123456', 'Oliver Martin', 'oliver@email.com', 10011);
INSERT INTO Staff (sAddress, sMobile, sName, sMail, sId) VALUES ('202 Spruce Ln', '567234567', 'Sophia Lee', 'sophia@email.com', 10012);
INSERT INTO Staff (sAddress, sMobile, sName, sMail, sId) VALUES ('303 Cherry Ave', '890345678', 'Liam Martinez', 'liam@email.com', 10013);
INSERT INTO Staff (sAddress, sMobile, sName, sMail, sId) VALUES ('404 Willow Rd', '123456789', 'Mia Rodriguez', 'mia@email.com', 10014);
INSERT INTO Staff (sAddress, sMobile, sName, sMail, sId) VALUES ('505 Poplar St', '234567890', 'Noah Davis', 'noah@email.com', 10015);
INSERT INTO Staff (sAddress, sMobile, sName, sMail, sId) VALUES ('606 Aspen Ct', '345678901', 'Isabella Lewis', 'isabella@email.com', 10016);
INSERT INTO Staff (sAddress, sMobile, sName, sMail, sId) VALUES ('707 Beech Blvd', '456789012', 'James White', 'james@email.com', 10017);
INSERT INTO Staff (sAddress, sMobile, sName, sMail, sId) VALUES ('88 Magnolia Way', '567890123', 'Charl Walker', 'charlotte@email.com', 10018);
INSERT INTO Staff (sAddress, sMobile, sName, sMail, sId) VALUES ('909 Oak Dr', '678901234', 'Ben Hall', 'benjamin@email.com', 10019);
INSERT INTO Staff (sAddress, sMobile, sName, sMail, sId) VALUES ('100 Redwood Ave', '789012345', 'Amelia Young', 'amelia@email.com', 10020);
--select * from Staff;

-- Insert data into Doctor table
INSERT INTO Doctor (License, Specialties, sId) VALUES ('L1234', 'Orthodontist', 10001);
INSERT INTO Doctor (License, Specialties, sId) VALUES ('L5678', 'Cosmetic', 10002);
INSERT INTO Doctor (License, Specialties, sId) VALUES ('L9012', 'Dentist', 10003);
INSERT INTO Doctor (License, Specialties, sId) VALUES ('L3456', 'Dentist', 10004);
INSERT INTO Doctor (License, Specialties, sId) VALUES ('L7890', 'Cosmetic', 10005);
INSERT INTO Doctor (License, Specialties, sId) VALUES ('L2345', 'Dentist', 10006);
INSERT INTO Doctor (License, Specialties, sId) VALUES ('L6789', 'Dentist', 10007);
INSERT INTO Doctor (License, Specialties, sId) VALUES ('L0123', 'Orthodontist', 10008);
INSERT INTO Doctor (License, Specialties, sId) VALUES ('L4567', 'Orthodontist', 10009);
INSERT INTO Doctor (License, Specialties, sId) VALUES ('L8901', 'Dentist', 10010);
--select * from Doctor;

-- Insert data into Office table
INSERT INTO Office (oType, sId) VALUES ('Secretariat', 10011);
INSERT INTO Office (oType, sId) VALUES ('Sales', 10012);
INSERT INTO Office (oType, sId) VALUES ('Secretariat', 10013);
INSERT INTO Office (oType, sId) VALUES ('Sales', 10014);
INSERT INTO Office (oType, sId) VALUES ('Secretariat', 10015);
INSERT INTO Office (oType, sId) VALUES ('Secretariat', 10016);
INSERT INTO Office (oType, sId) VALUES ('Sales', 10017);
INSERT INTO Office (oType, sId) VALUES ('Shift Manager', 10018);
INSERT INTO Office (oType, sId) VALUES ('Shift Manager', 10019);
INSERT INTO Office (oType, sId) VALUES ('Sales', 10020);
--select * from Office;

-- Insert data into Patient table
INSERT INTO Patient (cBirthYear, cAddress, cName, cGender, cId, cMobile, cMail) VALUES (1980, '123 Main St', 'Alice Johnson', 'F', 20001, '123456789', 'alice@email.com');
INSERT INTO Patient (cBirthYear, cAddress, cName, cGender, cId, cMobile, cMail) VALUES (1990, '456 Oak Ave', 'Bob Smith', 'M', 20002, '987654321', 'bob@email.com');
INSERT INTO Patient (cBirthYear, cAddress, cName, cGender, cId, cMobile, cMail) VALUES (1985, '789 Elm St', 'Charlie Davis', 'M', 20003, '456789012', 'charlie@email.com');
INSERT INTO Patient (cBirthYear, cAddress, cName, cGender, cId, cMobile, cMail) VALUES (1995, '321 Pine Rd', 'Danielle Wilson', 'F', 20004, '789012345', 'danielle@email.com');
INSERT INTO Patient (cBirthYear, cAddress, cName, cGender, cId, cMobile, cMail) VALUES (1988, '654 Maple Ln', 'Evan Thompson', 'M', 20005, '345678901', 'evan@email.com');
INSERT INTO Patient (cBirthYear, cAddress, cName, cGender, cId, cMobile, cMail) VALUES (1992, '987 Cedar Blvd', 'Fiona Anderson', 'F', 20006, '678901234', 'fiona@email.com');
INSERT INTO Patient (cBirthYear, cAddress, cName, cGender, cId, cMobile, cMail) VALUES (1982, '246 Oak Ct', 'George Taylor', 'M', 20007, '901234567', 'george@email.com');
INSERT INTO Patient (cBirthYear, cAddress, cName, cGender, cId, cMobile, cMail) VALUES (1998, '579 Elm Way', 'Hannah Brown', 'F', 20008, '234567890', 'hannah@email.com');
INSERT INTO Patient (cBirthYear, cAddress, cName, cGender, cId, cMobile, cMail) VALUES (1991, '813 Pine Ave', 'Ian Garcia', 'M', 20009, '567890123', 'ian@email.com');
INSERT INTO Patient (cBirthYear, cAddress, cName, cGender, cId, cMobile, cMail) VALUES (1987, '159 Maple St', 'Jill Roberts', 'F', 20010, '890123456', 'jill@email.com');
--select * from Patient;

-- Insert data into Appointment table
INSERT INTO Appointment (aDate, AppointmentID, sId, cId) VALUES (TO_DATE('01-05-2023', 'DD-MM-YYYY'), 30001, 10001, 20001);
INSERT INTO Appointment (aDate, AppointmentID, sId, cId) VALUES (TO_DATE('02-05-2023', 'DD-MM-YYYY'), 30002, 10006, 20002);
INSERT INTO Appointment (aDate, AppointmentID, sId, cId) VALUES (TO_DATE('03-05-2023', 'DD-MM-YYYY'), 30003, 10006, 20003);
INSERT INTO Appointment (aDate, AppointmentID, sId, cId) VALUES (TO_DATE('04-05-2023', 'DD-MM-YYYY'), 30004, 10001, 20004);
INSERT INTO Appointment (aDate, AppointmentID, sId, cId) VALUES (TO_DATE('05-05-2023', 'DD-MM-YYYY'), 30005, 10005, 20005);
INSERT INTO Appointment (aDate, AppointmentID, sId, cId) VALUES (TO_DATE('06-05-2023', 'DD-MM-YYYY'), 30006, 10006, 20006);
--select * from Appointment;

-- Insert data into Payment table
INSERT INTO Payment (Id, TotalPrice, pDate, AppointmentID) VALUES (40001, 100.00, TO_DATE('01-05-2023', 'DD-MM-YYYY'), 30001);
INSERT INTO Payment (Id, TotalPrice, pDate, AppointmentID) VALUES (40002, 150.50, TO_DATE('02-05-2023', 'DD-MM-YYYY'), 30002);
INSERT INTO Payment (Id, TotalPrice, pDate, AppointmentID) VALUES (40003, 75.25, TO_DATE('03-05-2023', 'DD-MM-YYYY'), 30003);
INSERT INTO Payment (Id, TotalPrice, pDate, AppointmentID) VALUES (40004, 200.00, TO_DATE('04-05-2023', 'DD-MM-YYYY'), 30004);
INSERT INTO Payment (Id, TotalPrice, pDate, AppointmentID) VALUES (40005, 125.75, TO_DATE('05-05-2023', 'DD-MM-YYYY'), 30005);
INSERT INTO Payment (Id, TotalPrice, pDate, AppointmentID) VALUES (40006, 175.50, TO_DATE('06-05-2023', 'DD-MM-YYYY'), 30006);
--select * from Payment;

-- Insert data into Material table
INSERT INTO Material (mId, mName, Amount) VALUES (50001,'Gauze',100);
INSERT INTO Material (mId, mName, Amount) VALUES (50002,'Bandages',75);
INSERT INTO Material (mId, mName, Amount) VALUES (50003,'Syringes',200);
INSERT INTO Material (mId, mName, Amount) VALUES (50004,'Scalpels',50);
INSERT INTO Material (mId, mName, Amount) VALUES (50005,'Gloves',300);
INSERT INTO Material (mId, mName, Amount) VALUES (50006,'Sutures',125);
INSERT INTO Material (mId, mName, Amount) VALUES (50007,'Cotton Swabs',400);
INSERT INTO Material (mId, mName, Amount) VALUES (50008,'Disinfectant',150);
INSERT INTO Material (mId, mName, Amount) VALUES (50009,'Thermometers',75);
INSERT INTO Material (mId, mName, Amount) VALUES (50010,'Stethoscopes',25);
--select * from Material;

-- Insert data into Treatment table
INSERT INTO Treatment (tType, Description, Price, tId, Time) VALUES ('Surgery','Appendectomy',10000,60001,2.5);
INSERT INTO Treatment (tType, Description, Price, tId, Time) VALUES ('Medication','Antibiotics',50,60002,0.5);
INSERT INTO Treatment (tType, Description, Price, tId, Time) VALUES ('Therapy','Physical Therapy',100,60003,1.0);
INSERT INTO Treatment (tType, Description, Price, tId, Time) VALUES ('Procedure','X-Ray',200,60004,0.25);
INSERT INTO Treatment (tType, Description, Price, tId, Time) VALUES ('Surgery','Knee Replacement',15000,60005,3.0);
INSERT INTO Treatment (tType, Description, Price, tId, Time) VALUES ('Medication','Pain Relievers',25,60006,0.25);
--select * from Treatment;
