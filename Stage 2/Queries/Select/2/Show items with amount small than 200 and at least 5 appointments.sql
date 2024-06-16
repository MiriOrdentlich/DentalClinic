SELECT m.mId, m.mName, m.Amount, COUNT(DISTINCT tpia.AppointmentID) AS appointment_count
FROM system.material m
JOIN system.musedint mui ON m.mId = mui.mId
JOIN system.treatment t ON mui.tId = t.tId
JOIN system.tpreformedina tpia ON t.tId = tpia.tId
WHERE m.Amount < 200
GROUP BY m.mId, m.mName, m.Amount
HAVING COUNT(DISTINCT tpia.AppointmentID) >= 5
ORDER BY m.mId;
