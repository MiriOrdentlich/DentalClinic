
--2023 payment deateles before delete 
SELECT p.Id, p.TotalPrice, p.pDate, a.aDate
FROM system.Payment p
JOIN system.Appointment a ON p.AppointmentID = a.AppointmentID
WHERE EXTRACT(YEAR FROM p.pDate) = 2023;

  --2023 delete
DELETE FROM system.Payment p
WHERE EXTRACT(YEAR FROM p.pDate) = 2023;
