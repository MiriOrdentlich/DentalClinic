
-- Select all from Doctor table
Select * from Doctor; -- Retrieves all doctor records

-- Select all from Patient table
Select * from Patient; -- Retrieves all patient records

-- Select all from Appointment table
Select * from Appointment; -- Retrieves all appointment records

-- Select all from Payment table
Select * from Payment; -- Retrieves all payment records

-- Select all from Stuff table
Select * from Staff; -- Retrieves all staff records (corrected from "Staff")

-- Select all from MusedinT table
Select * from MusedinT; -- Retrieves records from MusedinT table (materials/treatments used)

-- Select all from Treatment table
Select * from Treatment; -- Retrieves all treatment records

-- Select all from Material table
Select * from Material; -- Retrieves all material records

-- Select all from TperformedInA table
Select * from Tpreformedina; -- Retrieves records from TperformedInA table (treatments and appointments)

-- Select all from OMakeA table
Select * from OMakeA; -- Retrieves records from OMakeA table (offices and appointments)

-- For each Select - Checking the number of rows in the table
Select count(*) from Office;
Select count(*) from Doctor;
Select count(*) from Patient;
Select count(*) from Appointment;
Select count(*) from Payment;
Select count(*) from Staff;
Select count(*) from MusedinT;
Select count(*) from Treatment;
Select count(*) from Material;
Select count(*) from Tpreformedina;
Select count(*) from OMakeA; 
