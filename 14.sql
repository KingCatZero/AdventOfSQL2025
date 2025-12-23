WITH
	RECURSIVE graph AS (
    	SELECT
      		'Jake''s Lift' AS from_node
      		,'Jake''s Lift' AS pth
      		,1 AS pth_size
      
      		UNION ALL
      
      	SELECT
      		mn.to_node
      		,g.pth || ' -> ' || mn.to_node
      		,g.pth_size + 1
      	FROM graph AS g
      		INNER JOIN mountain_network AS mn ON
      			mn.from_node = g.from_node
    )
SELECT
	*
FROM graph
WHERE
	from_node = 'Maverick'
