{{ config(materialized='table', schema='staging') }}


WITH movies AS (
    SELECT
        *
    FROM {{ source('imdb_raw', 'raw_movies') }}
)

SELECT
    tconst as movie_id,
    titleType as movie_type,
    primaryTitle as movie_name,
    originalTitle as original_name,
    CAST(isAdult AS BOOL) as is_adult,
    (CASE WHEN startYear = '\N' THEN NULL ELSE CAST(startYear AS INTEGER) END) as start_year,
    (CASE WHEN endYear = '\N' THEN NULL ELSE CAST(endYear AS INTEGER) END) as end_year,
    (CASE WHEN runtimeMinutes = '\N' THEN NULL ELSE CAST(runtimeMinutes AS INTEGER) END) as duration,
    genres
FROM movies