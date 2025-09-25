{{ config(materialized='table', schema='staging') }}


WITH actors AS (
    SELECT
        *
    FROM {{ source('imdb_raw', 'raw_actors') }}
)

SELECT
    nconst as actor_id,
    primaryName as full_name,
    (CASE WHEN birthYear = '\N' THEN NULL ELSE CAST(birthYear AS INTEGER) END) as birth_year,
    (CASE WHEN deathYear = '\N' THEN NULL ELSE CAST(deathYear AS INTEGER) END) as death_year,
    primaryProfession as profession,
	knownForTitles as joined_movies
FROM actors