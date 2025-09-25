{{ config(materialized='table', schema='marts') }}

WITH dim_movies AS (
    SELECT
        *
    FROM {{ source('imdb_marts', 'dim_movies') }}
),

dim_actors AS (
    SELECT
        *
    FROM {{ source('imdb_marts', 'dim_actors') }}
),

stg_ratings as (
    SELECT
        *
    FROM {{ source('imdb_staging', 'stg_ratings') }}
)

SELECT
    dm.movie_key,
    r.average_rate,
    r.num_votes
FROM stg_ratings r
JOIN dim_movies dm ON dm.movie_id = r.movie_id

