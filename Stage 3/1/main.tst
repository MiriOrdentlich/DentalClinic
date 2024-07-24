PL/SQL Developer Test script 3.0
77
DECLARE
    -- Variables for mostVisitsPerson
    v_result VARCHAR2(200);
    v_from_date DATE;
    v_to_date DATE;
    
    -- Variables for create_appointment
    l_appointment_cursor SYS_REFCURSOR;
    l_appointment_id NUMBER;
    l_doctor_name VARCHAR2(100);
    l_patient_name VARCHAR2(100);
    l_appointment_date DATE;
    l_treatment_type VARCHAR2(15);
    
    l_doctor_id Doctor.sId%TYPE;
    l_patient_id Patient.cId%TYPE;
    l_treatment_id Treatment.tId%TYPE;
    l_input_date VARCHAR2(30);

    -- Helper function for date conversion
    FUNCTION convert_date(p_date IN VARCHAR2) RETURN DATE IS
    BEGIN
        RETURN TO_DATE(p_date, 'DD.MM.YYYY');
    EXCEPTION
        WHEN OTHERS THEN
            RETURN TO_DATE(p_date, 'YYYY-MM-DD');
    END;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Testing mostVisitsPerson function:');
    DBMS_OUTPUT.PUT_LINE('---------------------------------------');
    
    -- Test mostVisitsPerson
    BEGIN
        v_result := mostVisitsPerson(fromDate=> :fromDate, toDate=>:toDate);
        DBMS_OUTPUT.PUT_LINE('Result: ' || v_result);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error in mostVisitsPerson: ' || SQLERRM);
    END;
    
    DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Testing create_appointment function:');
    DBMS_OUTPUT.PUT_LINE('---------------------------------------');

    -- Test create_appointment
    BEGIN
    l_doctor_id := :Enter_Doctor_ID;
    l_patient_id := :Enter_Patient_ID;
    l_treatment_id := :Enter_Treatment_ID;
    l_input_date := :Enter_Appointment_Date;
    
    l_appointment_date := convert_date(l_input_date);

    create_appointment(
        p_doctor_id => l_doctor_id,
        p_patient_id => l_patient_id,
        p_appointment_date => l_appointment_date,
        p_treatment_id => l_treatment_id,
        p_appointment_cursor => l_appointment_cursor
    );
    
    FETCH l_appointment_cursor INTO l_appointment_id, l_doctor_name, l_patient_name, l_appointment_date, l_treatment_type;
    CLOSE l_appointment_cursor;
    
    DBMS_OUTPUT.PUT_LINE('Appointment created: ID=' || l_appointment_id || 
                         ', Doctor=' || l_doctor_name || 
                         ', Patient=' || l_patient_name || 
                         ', Date=' || TO_CHAR(l_appointment_date, 'DD.MM.YYYY') ||
                         ', Treatment=' || l_treatment_type);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred in the main block: ' || SQLERRM);
END;
6
Enter_Doctor_ID
1
﻿38187
5
Enter_Patient_ID
1
﻿971
5
Enter_Appointment_Date
1
﻿18.02.2025
5
Enter_Treatment_ID
1
﻿69548
5
fromDate
1
01/01/2000
12
toDate
1
01/01/2030
12
0
