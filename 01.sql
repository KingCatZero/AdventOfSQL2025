WITH
  T AS (
    SELECT
      child_name
      ,TRIM(LOWER(raw_wish)) AS wish
    FROM wish_list
  )
SELECT
  child_name
  ,COUNT(1) AS wish_cnt
FROM T
GROUP BY
  1
ORDER BY
  2 DESC
