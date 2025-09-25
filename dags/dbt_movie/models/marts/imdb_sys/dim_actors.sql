{{ config(materialized='table', schema='marts') }}

WITH stg_actors AS (
    SELECT
        *
    FROM {{ source('imdb_staging', 'stg_actors') }}
)

SELECT
    ROW_NUMBER() OVER (ORDER BY actor_id) as actor_key,
    actor_id,
    full_name,
    birth_year,
    death_year,
    profession
FROM stg_actors