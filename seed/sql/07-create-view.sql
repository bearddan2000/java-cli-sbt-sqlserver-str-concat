CREATE VIEW breed_count AS
WITH CTE_Id (id) AS
(
  SELECT 1
  union all
  SELECT id+1
  from CTE_Id
  where id < 4
)

SELECT b.id, b.breed as 'Breed', COUNT(*) as 'Breed Count'
FROM CTE_Id AS a
JOIN breedLookup AS b ON b.id = a.id
RIGHT JOIN dog AS c ON c.breedId = a.id
GROUP BY b.id, b.breed
