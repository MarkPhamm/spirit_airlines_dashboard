SELECT
  'Origin' AS location_type,
  d.airport AS airport,
  AVG(f.average_rating) AS avg_rating,
  COUNT(*) AS review_count
FROM SKYTRAX_REVIEWS_DB.MARTS.FCT_REVIEW f
JOIN SKYTRAX_REVIEWS_DB.MARTS.DIM_AIRLINE a
  ON f.airline_id = a.airline_id
JOIN SKYTRAX_REVIEWS_DB.MARTS.DIM_LOCATION d
  ON f.origin_location_id = d.location_id
WHERE a.airline_name = 'spirit airlines'
  AND LOWER(d.airport) <> 'unknown'
GROUP BY d.airport

UNION ALL

SELECT
  'Destination' AS location_type,
  d.airport AS airport,
  AVG(f.average_rating) AS avg_rating,
  COUNT(*) AS review_count
FROM SKYTRAX_REVIEWS_DB.MARTS.FCT_REVIEW f
JOIN SKYTRAX_REVIEWS_DB.MARTS.DIM_AIRLINE a
  ON f.airline_id = a.airline_id
JOIN SKYTRAX_REVIEWS_DB.MARTS.DIM_LOCATION d
  ON f.destination_location_id = d.location_id
WHERE a.airline_name = 'spirit airlines'
  AND LOWER(d.airport) <> 'unknown'
GROUP BY d.airport;
