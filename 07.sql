WITH
  top_3_cars AS (
    SELECT
      *
    FROM cocoa_cars
    ORDER BY
      total_stock DESC
    LIMIT 3
  )
SELECT
  p.passenger_name
  ,ARRAY_AGG(c.car_id)
FROM top_3_cars AS c
  INNER JOIN passengers AS p ON
    c.available_mixins && p.favorite_mixins
GROUP BY
  1
ORDER BY
  1
