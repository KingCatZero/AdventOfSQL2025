WITH
  LMS AS (
    SELECT
      id
      ,volunteer_name
      ,CASE
        WHEN LOWER(assigned_task) LIKE '%choir%' THEN 'choir_assistant'
        WHEN LOWER(assigned_task) LIKE '%stage%' THEN 'stage_setup'
        WHEN LOWER(assigned_task) LIKE '%parking%' THEN 'parking_support'
        WHEN LOWER(assigned_task) LIKE '%cocoa station%' THEN 'cocoa_station'
        WHEN LOWER(assigned_task) LIKE '%handwarmer%' THEN 'handwarmer_handout'
        WHEN LOWER(assigned_task) LIKE '%shovel%' THEN 'snow_shoveling'
      END AS role
      ,CASE
        WHEN LOWER(time_slot) LIKE '2%pm%' THEN '2:00 PM'
        WHEN LOWER(time_slot) LIKE '%noon%' THEN '12:00 PM'
        WHEN LOWER(time_slot) LIKE '%10%am%' THEN '10:00 AM'
      END AS shift_time
      ,NULL AS age_group
      ,NULL AS code
    FROM last_minute_signups AS t
    WHERE
      NOT EXISTS (
        SELECT
          1
        FROM official_shifts
        WHERE
          id = t.id
      )
  )
SELECT
  *
FROM (
  SELECT * FROM official_shifts
    UNION ALL
  SELECT * FROM LMS
) AS T
