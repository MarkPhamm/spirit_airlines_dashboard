SELECT
  DATE_TRUNC('year', f.date_submitted_id) AS review_year,
  AVG(f.average_rating) AS avg_rating,
  COUNT(*) AS review_count
FROM SKYTRAX_REVIEWS_DB.MARTS.FCT_REVIEW f
JOIN SKYTRAX_REVIEWS_DB.MARTS.DIM_AIRLINE a
  ON f.airline_id = a.airline_id
WHERE a.airline_name = 'spirit airlines'
GROUP BY 1
ORDER BY 1;
