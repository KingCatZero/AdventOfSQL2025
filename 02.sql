SELECT
  sc.official_category
  ,SUM(si.quantity) AS total_usable_snowballs
FROM snowball_inventory AS si
  INNER JOIN snowball_categories AS sc ON
    sc.official_category = si.category_name
WHERE
  si.quantity > 0
  AND si.status = 'ready'
GROUP BY
  1
ORDER BY
  2
