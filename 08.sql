WITH
  price_changes_with_rn AS (
    SELECT
      *
      ,LEAD(price) OVER (
        PARTITION BY
          product_id
        ORDER BY
          effective_timestamp DESC
      ) AS previous_price
      ,ROW_NUMBER() OVER (
        PARTITION BY
          product_id
        ORDER BY
          effective_timestamp DESC
      ) AS rn
    FROM price_changes
  )
SELECT
  p.product_name
  ,pc.price AS current_price
  ,pc.previous_price
  ,pc.price - pc.previous_price AS price_diff
FROM price_changes_with_rn AS pc
  INNER JOIN products AS p ON
    p.product_id = pc.product_id
WHERE
  rn = 1
ORDER BY
  1
