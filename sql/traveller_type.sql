WITH base AS (
  SELECT f.*
  FROM SKYTRAX_REVIEWS_DB.MARTS.FCT_REVIEW f
  JOIN SKYTRAX_REVIEWS_DB.MARTS.DIM_AIRLINE a
    ON f.airline_id = a.airline_id
  WHERE a.airline_name = 'spirit airlines'
),
band_counts AS (
  SELECT
    type_of_traveller,
    rating_band,
    COUNT(*) AS review_count
  FROM base
  GROUP BY 1, 2
),
traveller_avg AS (
  SELECT
    type_of_traveller,
    ROUND(AVG(average_rating), 2) AS avg_rating_traveller
  FROM base
  GROUP BY 1
),
overall AS (
  SELECT ROUND(AVG(average_rating), 2) AS spirit_overall_avg
  FROM base
)
SELECT
  bc.type_of_traveller,
  bc.rating_band,
  bc.review_count,
  ROUND(100.0 * bc.review_count / SUM(bc.review_count) OVER (PARTITION BY bc.type_of_traveller), 2) AS percent_share,
  ta.avg_rating_traveller,
  (SELECT spirit_overall_avg FROM overall) AS spirit_overall_avg
FROM band_counts bc
JOIN traveller_avg ta USING (type_of_traveller)
ORDER BY bc.type_of_traveller, bc.rating_band;
