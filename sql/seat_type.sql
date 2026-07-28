WITH base AS (
  SELECT f.*
  FROM SKYTRAX_REVIEWS_DB.MARTS.FCT_REVIEW f
  JOIN SKYTRAX_REVIEWS_DB.MARTS.DIM_AIRLINE a
    ON f.airline_id = a.airline_id
  WHERE a.airline_name = 'spirit airlines'
),
band_counts AS (
  SELECT
    seat_type,
    rating_band,
    COUNT(*) AS review_count
  FROM base
  GROUP BY 1, 2
),
seat_avg AS (
  SELECT
    seat_type,
    ROUND(AVG(average_rating), 3) AS avg_rating_seat
  FROM base
  GROUP BY 1
),
overall AS (
  SELECT ROUND(AVG(average_rating), 2) AS spirit_overall_avg
  FROM base
)
SELECT
  bc.seat_type,
  bc.rating_band,
  bc.review_count,
  ROUND(100.0 * bc.review_count / SUM(bc.review_count) OVER (PARTITION BY bc.seat_type), 2) AS percent_share,
  sa.avg_rating_seat,
  (SELECT spirit_overall_avg FROM overall) AS spirit_overall_avg
FROM band_counts bc
JOIN seat_avg sa USING (seat_type)
ORDER BY bc.seat_type, bc.rating_band;
