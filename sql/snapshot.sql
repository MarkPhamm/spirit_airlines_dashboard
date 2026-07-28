WITH base AS (
  SELECT f.*
  FROM SKYTRAX_REVIEWS_DB.MARTS.FCT_REVIEW f
  JOIN SKYTRAX_REVIEWS_DB.MARTS.DIM_AIRLINE a
    ON f.airline_id = a.airline_id
  WHERE a.airline_name = 'spirit airlines'
)
SELECT *
FROM base;
