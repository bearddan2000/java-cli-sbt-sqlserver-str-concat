CREATE VIEW dog_final AS
WITH CTE_Id (id) AS
(
  SELECT 1
  union all
  SELECT id+1
  from CTE_Id
  where id < 4
), CTE_Color (id, val) AS
(
  SELECT b.breedId, STUFF((
      SELECT ',' + color
      FROM dog a
      JOIN colorLookup c ON c.id = a.colorId
      WHERE b.breedId = a.breedId
          FOR XML PATH('')), 1, 1, '')
  FROM dog b
  GROUP BY b.breedId
)

SELECT b.id, b.breed as 'Breed',
COUNT(*) as 'Breed Count', d.val as 'Color'
FROM CTE_Id AS a
JOIN breedLookup AS b ON b.id = a.id
RIGHT JOIN dog AS c ON c.breedId = a.id
JOIN CTE_Color AS d ON c.breedId = d.id
GROUP BY b.id, b.breed, d.val
