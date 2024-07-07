CREATE OR REPLACE PROCEDURE create_appointment (
    p_doctor_id IN Doctor.sId%TYPE,
    p_patient_id IN Patient.cId%TYPE,
    p_appointment_date IN Appointment.aDate%TYPE,
    p_treatment_id IN Treatment.tId%TYPE,
    p_appointment_cursor OUT SYS_REFCURSOR
) AS
    -- Record type for appointment details
    TYPE appointment_record IS RECORD (
        appointment_id Appointment.AppointmentID%TYPE,
        doctor_name Staff.sName%TYPE,
        patient_name Patient.cName%TYPE,
        appointment_date Appointment.aDate%TYPE,
        treatment_type Treatment.tType%TYPE
    );
    
    v_appointment appointment_record;
    v_doctor_exists NUMBER;
    v_patient_exists NUMBER;
    v_treatment_exists NUMBER;
    v_appointment_id Appointment.AppointmentID%TYPE;
    v_current_date DATE := TRUNC(SYSDATE);
    v_doctor_appointments NUMBER;
    
    -- Custom exceptions
    e_invalid_doctor EXCEPTION;
    e_invalid_patient EXCEPTION;
    e_invalid_treatment EXCEPTION;
    e_past_date EXCEPTION;
    e_doctor_unavailable EXCEPTION;
    
BEGIN
    -- Check if doctor exists
    SELECT COUNT(*) INTO v_doctor_exists
    FROM Doctor
    WHERE sId = p_doctor_id;
    
    IF v_doctor_exists = 0 THEN
        RAISE e_invalid_doctor;
    END IF;
    
    -- Check if patient exists
    SELECT COUNT(*) INTO v_patient_exists
    FROM Patient
    WHERE cId = p_patient_id;
    IF v_patient_exists = 0 THEN
        RAISE e_invalid_patient;
    END IF;
    
    -- Check if treatment exists
    SELECT COUNT(*) INTO v_treatment_exists
    FROM Treatment
    WHERE tId = p_treatment_id;
    
    IF v_treatment_exists = 0 THEN
        RAISE e_invalid_treatment;
    END IF;
    
    -- Check if appointment date is in the future
    IF p_appointment_date <= v_current_date THEN
        RAISE e_past_date;
    END IF;
    
    -- Check doctor's availability (assuming max 10 appointments per day)
    SELECT COUNT(*) INTO v_doctor_appointments
    FROM Appointment
    WHERE sId = p_doctor_id AND aDate = p_appointment_date;
    
    IF v_doctor_appointments >= 10 THEN
        RAISE e_doctor_unavailable;
    END IF;
    
    -- Generate new appointment ID
    SELECT NVL(MAX(AppointmentID), 0) + 1 INTO v_appointment_id
    FROM Appointment;
    
    -- Insert new appointment
    INSERT INTO Appointment (AppointmentID, aDate, sId, cId)
    VALUES (v_appointment_id, p_appointment_date, p_doctor_id, p_patient_id);
    
    -- Insert treatment for the appointment
    INSERT INTO TPREFORMEDINA (tId, AppointmentID)
    VALUES (p_treatment_id, v_appointment_id);
    
    -- Fetch appointment details
    SELECT a.AppointmentID, s.sName, p.cName, a.aDate, t.tType
    INTO v_appointment
    FROM Appointment a
    JOIN Staff s ON a.sId = s.sId
    JOIN Patient p ON a.cId = p.cId
    JOIN TPREFORMEDINA tpa ON a.AppointmentID = tpa.AppointmentID
    JOIN Treatment t ON tpa.tId = t.tId
    WHERE a.AppointmentID = v_appointment_id;
    
    -- Return appointment details via REF CURSOR
    OPEN p_appointment_cursor FOR
        SELECT v_appointment.appointment_id AS appointment_id,
               v_appointment.doctor_name AS doctor_name,
               v_appointment.patient_name AS patient_name,
               v_appointment.appointment_date AS appointment_date,
               v_appointment.treatment_type AS treatment_type
        FROM DUAL;
    
    COMMIT;
    
EXCEPTION
    WHEN e_invalid_doctor THEN
        RAISE_APPLICATION_ERROR(-20001, 'Invalid doctor ID');
    WHEN e_invalid_patient THEN
        RAISE_APPLICATION_ERROR(-20002, 'Invalid patient ID');
    WHEN e_invalid_treatment THEN
        RAISE_APPLICATION_ERROR(-20003, 'Invalid treatment ID');
    WHEN e_past_date THEN
        RAISE_APPLICATION_ERROR(-20004, 'Appointment date must be in the future');
    WHEN e_doctor_unavailable THEN
        RAISE_APPLICATION_ERROR(-20005, 'Doctor is fully booked for this date');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END create_appointment;
/
