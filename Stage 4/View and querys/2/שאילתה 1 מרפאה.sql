WITH DoctorTreatments AS (
    SELECT 
        DoctorName,
        COUNT(*) AS TreatmentCount,
        AVG(Payment) AS AverageTreatmentCost
    FROM 
        TreatmentDetails
    GROUP BY 
        DoctorName
)
SELECT 
    DoctorName,
    TreatmentCount,
    AverageTreatmentCost
FROM 
    DoctorTreatments
WHERE 
    TreatmentCount = (SELECT MAX(TreatmentCount) FROM DoctorTreatments);
