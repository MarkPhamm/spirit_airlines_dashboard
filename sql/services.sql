WITH spirit_reviews AS (
  SELECT
    f.cabin_staff_service,
    f.inflight_entertainment,
    f.food_and_beverages,
    f.seat_comfort,
    f.wifi_and_connectivity
  FROM SKYTRAX_REVIEWS_DB.MARTS.FCT_REVIEW f
  JOIN SKYTRAX_REVIEWS_DB.MARTS.DIM_AIRLINE a
    ON f.airline_id = a.airline_id
  WHERE a.airline_name = 'spirit airlines'
)
SELECT
  rating_type,
  AVG(rating_value) AS avg_rating
FROM spirit_reviews
UNPIVOT (
  rating_value FOR rating_type IN (
    cabin_staff_service,
    inflight_entertainment,
    food_and_beverages,
    seat_comfort,
    wifi_and_connectivity
  )
) AS unpvt
GROUP BY rating_type
ORDER BY avg_rating DESC;
