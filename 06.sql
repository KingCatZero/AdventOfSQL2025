WITH
  all_records AS (
    SELECT
      ('2025-12-15'::date + (interval '1' day * s))::date AS dt
      ,f.*
    FROM GENERATE_SERIES(0, 10) AS s
      CROSS JOIN families AS f
  )
SELECT
  ar.dt AS unassigned_date
  ,ar.family_name AS name
FROM all_records AS ar
WHERE
  NOT EXISTS (
    SELECT
      1
    FROM deliveries_assigned
    WHERE
      family_id = ar.id
      AND gift_date = ar.dt
  )
ORDER BY
  1, 2
