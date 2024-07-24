--Change the id to bigger to evoide troubles
UPDATE STUDENT
SET student_id = student_id + 1000;

--transfer data from STUDENT to PATIENT
INSERT INTO PATIENT (cid, cname,cbirthyear, cmobile)
SELECT 
    student_id, 
    first_name || ' ' || last_name, 
    EXTRACT(YEAR FROM birth_date),
    phone
    --NULL, -- We don't have gender information in STUDENT
    --NULL, -- We don't have address information in STUDENT
    --NULL  -- We don't have email information in STUDENT
FROM STUDENT;

-- Drop columns that are now in PATIENT
ALTER TABLE STUDENT DROP COLUMN first_name;
ALTER TABLE STUDENT DROP COLUMN last_name;
ALTER TABLE STUDENT DROP COLUMN birth_date;
ALTER TABLE STUDENT DROP COLUMN phone;

-- Add foreign key reference to PATIENT
ALTER TABLE STUDENT ADD CONSTRAINT FK_STUDENT_PATIENT
FOREIGN KEY (student_id) REFERENCES PATIENT(cid);

-- Rename student_id to match PATIENT's primary key name
ALTER TABLE STUDENT RENAME COLUMN student_id TO cid;

-- Add primary key constraint
ALTER TABLE STUDENT ADD CONSTRAINT PK_STUDENT PRIMARY KEY (cid);
