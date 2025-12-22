WITH
  travel_manifests_agg AS (
    SELECT
      vehicle_id
      ,departure_time
      ,SUM(ARRAY_LENGTH(XPATH('//manifest/passengers/passenger', manifest_xml), 1)) AS passenger_cnt
    FROM travel_manifests
    WHERE
      vehicle_id LIKE 'CARGO%'
    GROUP BY
      1, 2
  )
SELECT
  *
FROM travel_manifests_agg
WHERE
  passenger_cnt > 20
ORDER BY
  2
