SELECT
  d.aircraft_model,
  d.aircraft_manufacturer,
  d.seat_capacity,
  AVG(f.average_rating) AS avg_rating,
  COUNT(*) AS review_count
FROM SKYTRAX_REVIEWS_DB.MARTS.FCT_REVIEW f
JOIN SKYTRAX_REVIEWS_DB.MARTS.DIM_AIRLINE a
  ON f.airline_id = a.airline_id
JOIN SKYTRAX_REVIEWS_DB.MARTS.DIM_AIRCRAFT d
  ON f.aircraft_id = d.aircraft_id
WHERE a.airline_name = 'spirit airlines'
GROUP BY d.aircraft_model, d.aircraft_manufacturer, d.seat_capacity
ORDER BY review_count DESC;
