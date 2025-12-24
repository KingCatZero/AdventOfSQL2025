WITH
  t1 AS (
    SELECT
      system_id
      ,dispatched_at
      ,payload->>'marker' AS marker
      ,2 AS source_number
    FROM incoming_dispatches
    WHERE
      payload->>'source' = 'primary'

      UNION ALL

    SELECT
      system_id
      ,dispatched_at
      ,marker_letter
      ,1
    FROM system_dispatches
    WHERE
      payload->>'source' = 'primary'
  )
  ,t2 AS (
    SELECT
      *
      ,ROW_NUMBER() OVER (
        PARTITION BY
          system_id
        ORDER BY
          dispatched_at DESC, source_number
      ) AS rn
    FROM t1
  )
SELECT
  STRING_AGG(marker, '' ORDER BY dispatched_at) AS phrase
FROM t2
WHERE
  rn = 1
