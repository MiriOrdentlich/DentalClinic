SELECT p.cName, d.Specialties, a.aDate, o.oType, t.Description, t.Price, m.mName, m.Amount, pay.TotalPrice
FROM Patient p
JOIN (
  SELECT cId
  FROM Patient
  WHERE EXTRACT(YEAR FROM SYSDATE) - cBirthYear >= 20
) eligible_patients ON p.cId = eligible_patients.cId
JOIN Appointment a ON p.cId = a.cId
JOIN OMakeA oma ON a.AppointmentID = oma.AppointmentID
JOIN Office o ON oma.sId = o.sId
JOIN Doctor d ON a.sId = d.sId
JOIN TPreformedInA tpia ON a.AppointmentID = tpia.AppointmentID
JOIN Treatment t ON tpia.tId = t.tId
JOIN MUsedInT mut ON t.tId = mut.tId
JOIN Material m ON mut.mId = m.mId
JOIN PAYMENT pay ON a.AppointmentID = pay.AppointmentID
ORDER BY a.aDate;