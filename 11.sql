WITH
  behaviors AS (
    SELECT
      *
      ,AVG(score) OVER (
        PARTITION BY
          child_id
        ORDER BY
          behavior_date
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
      ) AS score_avg_7d
    FROM behavior_logs
  )
SELECT
  child_id
  ,child_name
  ,behavior_date
FROM behaviors
WHERE
  behavior_date >= '2025-12-07'
  AND score_avg_7d < 0
ORDER BY
  3, 2
