{{ config(materialized='table', schema='staging') }}


WITH ratings AS (
    SELECT
        *
    FROM {{ source('imdb_raw', 'raw_ratings') }}
)

SELECT
    tconst as movie_id,
    averageRating as average_rate,
    numVotes as num_votes
FROM ratings