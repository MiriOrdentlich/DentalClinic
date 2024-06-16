SELECT 
    system.p.cId AS PatientID,
    system.p.cName AS PatientName,
    system.t.tId AS TreatmentID,
    system.t.tType AS TreatmentType,
    system.a.aDate AS AppointmentDate
FROM 
    system.Patient p
JOIN 
    system.Appointment a ON system.p.cId = system.a.cId
JOIN 
    system.TPreformedInA tp ON system.a.AppointmentID = system.tp.AppointmentID
JOIN 
    system.Treatment t ON system.tp.tId = system.t.tId
WHERE 
    system.p.cId =(&<name=Patient_id list="select distinct p.cId from Patient p order by p.cId" hint="Patient Id has 5 digits" required= true type=integer >)
ORDER BY 
    system.a.aDate;
    
