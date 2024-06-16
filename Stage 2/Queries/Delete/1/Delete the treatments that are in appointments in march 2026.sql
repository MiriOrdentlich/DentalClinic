--Show the treatments that are in appointments in march 2026 (To see before and after)
SELECT tpia.*, a.ADATE
FROM system.tpreformedina tpia
INNER JOIN system.appointment a ON a.AppointmentID = tpia.AppointmentID
WHERE EXTRACT(MONTH FROM a.aDate) = 3
  AND EXTRACT(YEAR FROM a.aDate) = 2026;

--Delete them
DELETE FROM system.tpreformedina tpia
WHERE tpia.AppointmentID IN (
  SELECT a.AppointmentID
  FROM system.appointment a
  WHERE EXTRACT(MONTH FROM a.aDate) = 3
    AND EXTRACT(YEAR FROM a.aDate) = 2026
);
