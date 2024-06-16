SELECT
  system.p.cId,
  system.p.cName,
  system.p.cGender,
  system.p.cBirthYear,
  system.p.cAddress, -- Use the correct column
  system.py.TotalPrice,
  system.py.pDate,
  system.t.tType,
  system.t.Description,
  system.d.sId,
  system.d.Specialties
FROM
  system.Patient p
  JOIN system.Appointment a ON system.p.cId = system.a.cId
  JOIN system.TPreformedInA tpia ON system.a.AppointmentID = system.tpia.AppointmentID
  JOIN system.Treatment t ON system.tpia.tId = system.t.tId
  JOIN system.OMakeA oma ON system.a.AppointmentID = system.oma.AppointmentID
  JOIN system.Office o ON system.oma.sId = system.o.sId
  JOIN system.Doctor d ON system.o.sId = system.d.sId
  JOIN system.Payment py ON system.a.AppointmentID = system.py.AppointmentID
WHERE
  system.py.pDate >= ADD_MONTHS(SYSDATE, -36) -- Filter by payments in the last 36 months
GROUP BY
  system.p.cId,
  system.p.cName,
  system.p.cGender,
  system.p.cBirthYear,
  system.p.cAddress,
  system.py.TotalPrice,
  system.py.pDate,
  system.t.tType,
  system.t.Description,
  system.d.sId,
  system.d.Specialties
ORDER BY
  system.py.pDate DESC; -- Order by payment date descending

