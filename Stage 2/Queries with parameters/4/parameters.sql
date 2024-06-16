SELECT 
    s.sName AS DoctorName,
    d.Specialties,
    a.aDate,
    TO_CHAR(a.aDate, 'DAY', 'NLS_DATE_LANGUAGE=ENGLISH') AS DayOfWeek,
    t.tType,
    t.Price
FROM system.staff s
JOIN system.doctor d ON s.sId = d.sId
JOIN system.appointment a ON d.sId = a.sId
JOIN system.tpreformedina tpia ON a.AppointmentID = tpia.AppointmentID
JOIN system.treatment t ON tpia.tId = t.tId
WHERE a.aDate BETWEEN &<name=start_date hint="Enter start date (dd/mm/yyyy)" type=date> 
                 AND &<name=end_date hint="Enter end date (dd/mm/yyyy)" type=date>
  AND TO_CHAR(a.aDate, 'D', 'NLS_DATE_LANGUAGE=ENGLISH') IN ('5', '7') -- 1 for Sunday, 7 for Saturday
  AND t.Price > &<name=min_price hint="Enter minimum treatment price" type=INTEGER>
ORDER BY a.aDate, s.sName;
