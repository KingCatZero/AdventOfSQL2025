WITH
  most_recent_orders AS (
    SELECT
      *
    FROM (
      SELECT
        *
        ,ROW_NUMBER() OVER (
          PARTITION BY
            customer_id
          ORDER BY
            created_at DESC
        ) AS rn
      FROM orders
    ) AS t
    WHERE
      rn = 1
  )
SELECT
  customer_id
  ,created_at
  ,(order_data->'gift'->>'wrapped')::boolean AS gift_wrapped
  ,order_data->'shipping'->>'method' AS shipping_method
  ,order_data->'risk'->>'flag' AS risk_flag
FROM most_recent_orders
ORDER BY
  2 DESC
