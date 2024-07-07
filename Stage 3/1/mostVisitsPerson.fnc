CREATE OR REPLACE FUNCTION mostVisitsPerson(fromDate IN appointment.aDate%TYPE, toDate IN appointment.aDate%TYPE)
RETURN VARCHAR
IS
    fanPatientId Patient.cId%TYPE;
    PatientNumApps INTEGER := 0;
    fanDoctorId Doctor.sId%TYPE;
    doctorNumApps INTEGER := 0;
    almostFanId INTEGER := 0;
    almostFanType VARCHAR2(20);
    almostFanName VARCHAR2(100);
    almostFanNumArrivals INTEGER := 0;
    FunctionResult VARCHAR2(200);
    v_new_sId Doctor.sId%TYPE;
    v_rows_updated INTEGER;
    v_today DATE := TRUNC(SYSDATE);
    
      -- Define a record type to hold patient prize information
    TYPE prize_rec IS RECORD (
      patient_id Patient.cId%TYPE,
      treatment_id Treatment.tId%TYPE,
      treatment_name Treatment.tType%TYPE
    );
    
    -- Create a variable of the record type
    v_prize prize_rec;
    
    -- Define a cursor to select a free treatment from the Treatment table
    CURSOR free_treatment_cursor IS
      SELECT tId, tType FROM Treatment WHERE Price > 0
      ORDER BY DBMS_RANDOM.VALUE;
      
    -- Define a variable to hold treatment details
    v_treatment_id Treatment.tId%TYPE;
    v_treatment_name Treatment.tType%TYPE;
BEGIN
    -- Find the second most frequent patient
    BEGIN
        SELECT cId, num_apps INTO fanPatientId, PatientNumApps
        FROM (
            SELECT cId, COUNT(*) AS num_apps,
                   ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS rn
            FROM appointment
            WHERE aDate BETWEEN fromDate AND toDate
            GROUP BY cId
        )
        WHERE rn = 1;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No second most fan patient found.');
            RETURN 'No second most fan patient found.';
    END;

    -- Find the second most frequent doctor
    BEGIN
        SELECT sId, num_apps INTO fanDoctorId, doctorNumApps
        FROM (
            SELECT sId, COUNT(*) AS num_apps,
                   ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS rn
            FROM appointment
            WHERE aDate BETWEEN fromDate AND toDate
            GROUP BY sId
        )
        WHERE rn = 1;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No second most fan doctor found.');
            RETURN 'No second most fan doctor found.';
    END;

    DBMS_OUTPUT.PUT_LINE('Almost most fan Patient: ' || fanPatientId || ' visited here: ' || PatientNumApps || ' times!');
    DBMS_OUTPUT.PUT_LINE('Almost most fan doctor: ' || fanDoctorId || ' served here: ' || doctorNumApps || ' times!');

    IF PatientNumApps > doctorNumApps THEN
        almostFanId := fanPatientId;
        almostFanType := 'Patient';
        almostFanNumArrivals := PatientNumApps;
        SELECT cName INTO almostFanName FROM Patient WHERE cId = almostFanId;
        -- Assign a free treatment to the patient
      OPEN free_treatment_cursor;
      --FETCH free_treatment_cursor INTO v_treatment_id, v_treatment_name;
       
       --Make a loop instead
       LOOP
        FETCH free_treatment_cursor INTO v_treatment_id, v_treatment_name;
        -- Exit the loop if no more rows to fetch
        EXIT WHEN free_treatment_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Fetched Treatment ID: ' || v_treatment_id || ', Name: ' || v_treatment_name);
        EXIT;  -- Exit after fetching the first treatment
        END LOOP;
      CLOSE free_treatment_cursor;

      IF v_treatment_id IS NOT NULL THEN
        -- Create a prize record with the patient ID and treatment details
        v_prize.patient_id := almostFanId;
        v_prize.treatment_id := v_treatment_id;
        v_prize.treatment_name := v_treatment_name;
        
        -- Print or store the prize information
        DBMS_OUTPUT.PUT_LINE('Congratulations to Patient ' || v_prize.patient_id || '! You have won a free treatment: ' || v_prize.treatment_name || '.');

    ELSE
      DBMS_OUTPUT.PUT_LINE('No available treatments for the prize.');
    END IF;

    
    ELSIF doctorNumApps > PatientNumApps THEN
        almostFanId := fanDoctorId;
        almostFanType := 'Doctor';
        almostFanNumArrivals := doctorNumApps;
        SELECT sName INTO almostFanName FROM Staff WHERE sId = almostFanId;

        -- Find a suitable replacement doctor and update appointment
        BEGIN
            -- Check if there are any future appointments
            DECLARE
                v_future_appointments INTEGER;
            BEGIN
                SELECT COUNT(*) INTO v_future_appointments
                FROM system.appointment
                WHERE sId = fanDoctorId AND aDate > SYSDATE;

                IF v_future_appointments > 0 THEN
                    -- Find a suitable replacement doctor
                    BEGIN
                        SELECT d.sId INTO v_new_sId
                        FROM (
                            SELECT d.sId
                            FROM system.doctor d
                            WHERE d.Specialties = (
                                SELECT d2.Specialties
                                FROM system.doctor d2
                                WHERE d2.sId = fanDoctorId
                            )
                            AND d.sId <> fanDoctorId
                            ORDER BY dbms_random.value
                        ) d
                        WHERE ROWNUM = 1;

                        -- Update one future appointment for the second most popular doctor
                        UPDATE system.appointment
                        SET sId = v_new_sId
                        WHERE sId = fanDoctorId
                        AND aDate > v_today
                        AND ROWNUM = 1;
                        
                        v_rows_updated := SQL%ROWCOUNT;

                        IF v_rows_updated > 0 THEN
                            DBMS_OUTPUT.PUT_LINE('Appointment updated for doctor: ' || fanDoctorId);
                        ELSE
                            DBMS_OUTPUT.PUT_LINE('Failed to update appointment for doctor: ' || fanDoctorId);
                        END IF;
                        Commit;
                    EXCEPTION
                        WHEN OTHERS THEN
                            DBMS_OUTPUT.PUT_LINE('Error finding or updating appointment: ' || SQLERRM);
                    END;
                ELSE
                    DBMS_OUTPUT.PUT_LINE('No future appointments found for doctor: ' || fanDoctorId);
                END IF;
            END;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error in nested block: ' || SQLERRM);
        END;
    ELSIF PatientNumApps = doctorNumApps THEN
    almostFanType := 'Tie';
    almostFanName := 'Both Patient and Doctor have the same number of appointments!';
    almostFanNumArrivals := PatientNumApps; -- or doctorNumApps, they're equal in this case
    END IF;

    FunctionResult := 'To sum up, the almost most fan of us is the ' || almostFanType || ': ' || almostFanName ||
                      ' who was here ' || almostFanNumArrivals || ' times!!!';
    DBMS_OUTPUT.PUT_LINE(FunctionResult);

    RETURN FunctionResult;
END secondMostVisitsPerson;
/
