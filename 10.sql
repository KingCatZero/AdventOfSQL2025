CREATE TEMP TABLE to_move AS
SELECT
  *
  ,NOW() AS flagged_at
  ,'Invalid delivery location' AS reason
FROM deliveries
WHERE
  delivery_location IN ('Volcano Rim', 'Drifting Igloo', 'Abandoned Lighthouse', 'The Vibes')

DELETE
FROM deliveries
WHERE
  delivery_location IN ('Volcano Rim', 'Drifting Igloo', 'Abandoned Lighthouse', 'The Vibes')

SELECT
  *
FROM to_move
