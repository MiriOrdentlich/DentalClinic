SELECT DISTINCT 
    p.cId ,p.cName,p.cGender,a.aDate,t.tType,t.Price
FROM system.patient p
JOIN system.appointment a ON p.cId = a.cId
JOIN system.tpreformedina tpia ON a.AppointmentID = tpia.AppointmentID
JOIN system.treatment t ON tpia.tId = t.tId
WHERE a.aDate BETWEEN &<name=start_date hint="Enter start date (dd/mm/yyyy)" type=date> 
                 AND &<name=end_date hint="Enter end date (dd/mm/yyyy)" type=date>
  AND t.tType IN (&<name=treatment_types list="'Rehabilitation','Orthodontics', 'Aesthetic'" multiselect="true" required=true>)
ORDER BY p.cId &<name="Desc or Asc order" checkbox="desc,asc">;
