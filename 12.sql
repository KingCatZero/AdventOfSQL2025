WITH
  t1 AS (
    SELECT
      *
      ,CASE
        WHEN LOWER(title) LIKE '%fly%' THEN 2
        WHEN LOWER(title) LIKE '%flight%' THEN 2
        WHEN LOWER(description) LIKE '%fly%' THEN 1
        WHEN LOWER(description) LIKE '%flight%' THEN 1
      END AS score
    FROM archive_records
  )
  ,t2 AS (
    SELECT
      *
      ,ROW_NUMBER() OVER (
        ORDER BY
          score DESC
      ) AS rn
    FROM t1
    WHERE
      score > 0
  )
SELECT
  id
  ,title
  ,description
FROM t2
ORDER BY
  rn
LIMIT 5
