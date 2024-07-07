CREATE OR REPLACE FUNCTION Best_Doc RETURN VARCHAR2 IS
    Result VARCHAR2(100);

    -- Explicit cursor for doctors
    CURSOR doctor_cur IS
        SELECT s.sId, s.sName, d.Specialties, d.License
        FROM Staff s
        JOIN Doctor d ON s.sId = d.sId;

    -- Variables
    v_best_doctor_name VARCHAR2(30);
    v_max_performance_score NUMBER := 0;

    -- Record type for doctor details
    TYPE doctor_rec_type IS RECORD (
        id NUMBER,
        name VARCHAR2(30),
        specialty VARCHAR2(15),
        license VARCHAR2(15),
        appointment_count NUMBER,
        total_price NUMBER,
        performance_score NUMBER
    );
    v_doctor_rec doctor_rec_type;

BEGIN
    -- Loop through doctors using explicit cursor
    FOR doctor_row IN doctor_cur LOOP
        -- Use implicit cursor to get appointment details
        SELECT COUNT(a.AppointmentID), NVL(SUM(p.TotalPrice), 0)
        INTO v_doctor_rec.appointment_count, v_doctor_rec.total_price
        FROM Appointment a
        LEFT JOIN Payment p ON a.AppointmentID = p.AppointmentID
        WHERE a.sId = doctor_row.sId;

        v_doctor_rec.id := doctor_row.sId;
        v_doctor_rec.name := doctor_row.sName;
        v_doctor_rec.specialty := doctor_row.Specialties;
        v_doctor_rec.license := doctor_row.License;

        -- Calculate performance score (you can adjust this formula as needed)
        v_doctor_rec.performance_score := v_doctor_rec.appointment_count * v_doctor_rec.total_price / 1000;

        -- Check if this doctor has the best performance so far
        IF v_doctor_rec.performance_score > v_max_performance_score THEN
            v_max_performance_score := v_doctor_rec.performance_score;
            v_best_doctor_name := v_doctor_rec.name;
        END IF;
    END LOOP;

    -- Check if a best doctor was found
    IF v_best_doctor_name IS NOT NULL THEN
        Result := 'The best doctor is ' || v_best_doctor_name;
    ELSE
        Result := 'No doctors found or no appointments scheduled.';
    END IF;

    RETURN Result;

EXCEPTION
    WHEN OTHERS THEN
        Result := 'An error occurred: ' || SQLERRM;
        RETURN Result;
END Best_Doc;
/
