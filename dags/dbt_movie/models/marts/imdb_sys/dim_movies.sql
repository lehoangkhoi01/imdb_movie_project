{{ config(materialized='table', schema='marts') }}

WITH stg_movies AS (
    SELECT
        *
    FROM {{ source('imdb_staging', 'stg_movies') }}
)

SELECT
    ROW_NUMBER() OVER (ORDER BY movie_id) as movie_key,
    movie_id,
    movie_type,
    movie_name,
    original_name,
    is_adult,
    start_year,
    end_year,
    duration,
    genres
FROM stg_movies