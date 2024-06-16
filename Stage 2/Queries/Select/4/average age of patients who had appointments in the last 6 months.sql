SELECT 
    p.cGender,
    ROUND(AVG(EXTRACT(YEAR FROM SYSDATE) - p.cBirthYear)) AS avg_age,
    COUNT(DISTINCT p.cId) AS patient_count
FROM system.patient p
JOIN system.appointment a ON p.cId = a.cId
WHERE a.aDate >= ADD_MONTHS(SYSDATE, -6)
  AND a.aDate <= SYSDATE
GROUP BY p.cGender
ORDER BY avg_age DESC;
