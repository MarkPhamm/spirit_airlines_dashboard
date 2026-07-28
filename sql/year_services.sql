WITH base AS (
  SELECT
    DATE_TRUNC('year', f.date_submitted_id) AS review_year,
    f.cabin_staff_service,
    f.food_and_beverages,
    f.ground_service,
    f.inflight_entertainment,
    f.wifi_and_connectivity
  FROM SKYTRAX_REVIEWS_DB.MARTS.FCT_REVIEW f
  JOIN SKYTRAX_REVIEWS_DB.MARTS.DIM_AIRLINE a
    ON f.airline_id = a.airline_id
  WHERE a.airline_name = 'spirit airlines'
    AND f.date_submitted_id IS NOT NULL
)
SELECT
  review_year,
  rating_type,
  AVG(rating_value) AS avg_rating,
  COUNT(rating_value) AS review_count
FROM base
UNPIVOT (
  rating_value FOR rating_type IN (
    cabin_staff_service,
    food_and_beverages,
    ground_service,
    inflight_entertainment,
    wifi_and_connectivity
  )
) u
GROUP BY review_year, rating_type
ORDER BY review_year, rating_type;
