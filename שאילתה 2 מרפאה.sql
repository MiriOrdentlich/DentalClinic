SELECT 
    TreatmentType,
    COUNT(*) AS TreatmentCount
FROM 
    TreatmentDetails
GROUP BY 
    TreatmentType
ORDER BY 
    TreatmentCount DESC;
