UPDATE hotline_messages
SET
  statuc = 'approved'
WHERE
  status IS NULL
  AND LOWER(transcript) LIKE '%sorry%';

DELETE
FROM hotline_messages
WHERE
  tag IN ('penguin prank', 'time-loop advisory', 'possible dragon', 'nonsense alert')
  OR caller_name = 'Test Caller';
  
SELECT
  COUNT(CASE WHEN status IS NULL THEN 1 ELSE NULL END) AS null_cnt
  ,COUNT(CASE WHEN status = 'approved' THEN 1 ELSE NULL END) AS approved_cnt
FROM hotline_messages
