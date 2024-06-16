-- Update the amount for the top 20 most used materials
UPDATE system.material m
SET m.Amount = m.Amount + 10
WHERE m.mId IN (
  SELECT mId
  FROM (
    SELECT m.mId
    FROM system.material m
    JOIN system.musedint mui ON m.mId = mui.mId
    JOIN system.treatment t ON mui.tId = t.tId
    JOIN system.tpreformedina tpia ON t.tId = tpia.tId
    GROUP BY m.mId
    ORDER BY COUNT(*) DESC
  )
  WHERE ROWNUM <= 20
);

-- Find the top 20 most used (in appointments) materials (use to see the before and after the change)
SELECT *
  FROM (
  SELECT m.mId, m.mName, m.amount, COUNT(*) AS usageCount
  FROM system.material m
  JOIN system.musedint mui ON m.mId = mui.mId
  JOIN system.treatment t ON mui.tId = t.tId
  JOIN system.tpreformedina tpia ON t.tId = tpia.tId
  GROUP BY m.mId, m.mName, m.amount
  ORDER BY COUNT(*) DESC
)
  WHERE ROWNUM <= 20


