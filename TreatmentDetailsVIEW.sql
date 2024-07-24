CREATE VIEW TreatmentDetails AS
SELECT 
    t.tType AS TreatmentType,
    a.aDate AS AppointmentDate,
    s.sName AS DoctorName,
    p.TotalPrice AS Payment
FROM 
    Treatment t
JOIN TPreformedInA tpa ON t.tId = tpa.tId
JOIN Appointment a ON tpa.AppointmentID = a.AppointmentID
JOIN Staff s ON a.sId = s.sId
JOIN Doctor d ON s.sId = d.sId
LEFT JOIN Payment p ON a.AppointmentID = p.AppointmentID;

-- לשימוש בתצוגה:
 SELECT * FROM TreatmentDetails;
