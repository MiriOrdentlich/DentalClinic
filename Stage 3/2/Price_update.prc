CREATE OR REPLACE PROCEDURE Price_update(
  p_min_appointments IN NUMBER DEFAULT 4,
  p_price_increase_percent IN NUMBER DEFAULT 10
) IS
  CURSOR treatment_cursor IS
    SELECT t.tId, t.tType, t.Description, t.Price, t.Time, COUNT(*) as appointment_count
    FROM Treatment t
    JOIN TPreformedInA tpa ON t.tId = tpa.tId
    GROUP BY t.tId, t.tType, t.Description, t.Price, t.Time
    HAVING COUNT(*) >= p_min_appointments;

  TYPE treatment_record IS RECORD (
    tId Treatment.tId%TYPE,
    tType Treatment.tType%TYPE,
    Description Treatment.Description%TYPE,
    Price Treatment.Price%TYPE,
    Time Treatment.Time%TYPE,
    appointment_count NUMBER
  );
  
  TYPE treatment_table_type IS TABLE OF treatment_record INDEX BY PLS_INTEGER;
  v_treatment_table treatment_table_type;
  v_treatments_updated NUMBER := 0;
  
  no_popular_treatments EXCEPTION;
  invalid_price_increase EXCEPTION;

BEGIN
  -- Input validation
  IF p_price_increase_percent <= 0 THEN
    RAISE invalid_price_increase;
  END IF;

  -- Populate the treatment table
  OPEN treatment_cursor;
  FETCH treatment_cursor BULK COLLECT INTO v_treatment_table;
  CLOSE treatment_cursor;

  -- Check if any treatments qualify
  IF v_treatment_table.COUNT = 0 THEN
    RAISE no_popular_treatments;
  END IF;

  -- Process each qualifying treatment
  FOR i IN 1..v_treatment_table.COUNT LOOP
    v_treatments_updated := v_treatments_updated + 1;
    
    UPDATE Treatment
    SET Price = Price * (1 + p_price_increase_percent / 100)
    WHERE tId = v_treatment_table(i).tId;
    
    DBMS_OUTPUT.PUT_LINE('Treatment ' || v_treatment_table(i).tType || 
                         ' price increased from ' || v_treatment_table(i).Price ||
                         ' to ' || (v_treatment_table(i).Price * (1 + p_price_increase_percent / 100)));
  END LOOP;

  COMMIT;
  
  DBMS_OUTPUT.PUT_LINE('-------- Summary --------');
  DBMS_OUTPUT.PUT_LINE(v_treatments_updated || ' treatments updated');

EXCEPTION
  WHEN no_popular_treatments THEN
    RAISE_APPLICATION_ERROR(-20001, 'No treatments found with ' || p_min_appointments || ' or more appointments');
  WHEN invalid_price_increase THEN
    RAISE_APPLICATION_ERROR(-20002, 'Invalid price increase percentage. Please provide a positive number.');
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
    RAISE;
END Price_update;
/
