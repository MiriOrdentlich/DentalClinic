SELECT o.sId, s.sName, COUNT(DISTINCT a.AppointmentID) AS appointment_count
FROM system.office o
JOIN system.staff s ON o.sId = s.sId
JOIN system.omakea oma ON o.sId = oma.sId
JOIN system.appointment a ON oma.AppointmentID = a.AppointmentID
GROUP BY o.sId, s.sName
HAVING COUNT(DISTINCT a.AppointmentID) >= 10
ORDER BY appointment_count DESC;
