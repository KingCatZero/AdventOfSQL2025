WITH
  to_move AS (
    DELETE
    FROM deliveries
    WHERE
      delivery_location IN ('Volcano Rim', 'Drifting Igloo', 'Abandoned Lighthouse', 'The Vibes')
    RETURNING
      id, child_name, delivery_location, gift_name, scheduled_at
  )
INSERT INTO misdelivered_presents (
  id, child_name, delivery_location, gift_name, scheduled_at, flagged_at, reason
)
SELECT
  id, child_name, delivery_location, gift_name, scheduled_at, NOW(), 'Invalid delivery location'
FROM to_move
RETURNING *
