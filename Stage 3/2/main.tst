PL/SQL Developer Test script 3.0
60
CREATE OR REPLACE PROCEDURE main_class_management(
 p_user_threshold IN NUMBER DEFAULT NULL
) AS
 TYPE class_id_array IS TABLE OF NUMBER;
 v_class_ids class_id_array;
 v_popularity_threshold NUMBER;
 v_evaluation_result class_popularity_result;
 v_total_popularity NUMBER := 0;
 v_class_count NUMBER := 0;
 v_result_cursor SYS_REFCURSOR;
BEGIN
 -- Step 1: Fetch all class IDs
 SELECT class_number BULK COLLECT INTO v_class_ids
 FROM class_lesson
 ORDER BY class_number;
 -- Step 2: Evaluate all classes and calculate average popularity
 DBMS_OUTPUT.PUT_LINE('Evaluating all classes.');
 DBMS_OUTPUT.PUT_LINE('-----------------------------');
 FOR i IN 1..v_class_ids.COUNT LOOP
 v_evaluation_result := evaluate_class_popularity(v_class_ids(i), 
v_result_cursor);
 v_total_popularity := v_total_popularity + 
v_evaluation_result.popularity_rate;
 v_class_count := v_class_count + 1;
 END LOOP;
 -- Calculate threshold
 IF p_user_threshold IS NOT NULL THEN
 v_popularity_threshold := p_user_threshold;
 ELSE
 -- Set threshold to average popularity rate + 10%
 v_popularity_threshold := (v_total_popularity / v_class_count) + 10;
 END IF;
 DBMS_OUTPUT.PUT_LINE('Popularity threshold set to: ' || 
v_popularity_threshold || '%');
 DBMS_OUTPUT.PUT_LINE('-----------------------------');
 -- Step 3: Display popular classes
 DBMS_OUTPUT.PUT_LINE('Popular classes:');
 DBMS_OUTPUT.PUT_LINE(' ');
 FOR i IN 1..v_class_ids.COUNT LOOP
 v_evaluation_result := evaluate_class_popularity(v_class_ids(i), 
v_result_cursor);
 IF v_evaluation_result.popularity_rate >= v_popularity_threshold THEN
 DBMS_OUTPUT.PUT_LINE('Class Number: ' || 
v_evaluation_result.class_number || 
 ', Popularity Rate: ' || v_evaluation_result.popularity_rate || 
 '%, Recommendation: ' || v_evaluation_result.recommendation);
 END IF;
 END LOOP;
 -- Step 4: Update popular classes
 DBMS_OUTPUT.PUT_LINE('-----------------------------');
 DBMS_OUTPUT.PUT_LINE('Updating popular classes:');
 DBMS_OUTPUT.PUT_LINE(' ');
 update_classes_by_popularity(v_popularity_threshold);
 DBMS_OUTPUT.PUT_LINE('Class updates completed.');
EXCEPTION
 WHEN OTHERS THEN
 DBMS_OUTPUT.PUT_LINE('An error occurred in main_class_management: ' || 
SQLERRM);
 RAISE;
END main_class_management;
0
0
