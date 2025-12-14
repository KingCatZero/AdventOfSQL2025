SELECT
	*
FROM (
  SELECT
      *
      ,ROW_NUMBER() OVER (
          PARTITION BY
              user_name
          ORDER BY
              artist_cnt DESC, artist
      ) AS artist_rank
  FROM (
    SELECT
        user_name
    	,artist
        ,COUNT(1) AS artist_cnt
    FROM listening_logs
    GROUP BY
        1, 2
  ) AS T1
) AS T2
WHERE
	artist_rank <= 3
ORDER BY
	1, 3 DESC
