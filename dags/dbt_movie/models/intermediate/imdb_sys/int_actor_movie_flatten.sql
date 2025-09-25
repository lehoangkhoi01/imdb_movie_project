{{ config(materialized='table', schema='intermediate') }}

WITH stg_actors AS (
    SELECT
        *
    FROM {{ source('imdb_staging', 'stg_actors') }}
)

SELECT
    actor_id,
    full_name,
    TRIM(unnest(string_to_array(joined_movies, ','))) as movie_id
FROM stg_actors
WHERE joined_movies IS NOT NULL
