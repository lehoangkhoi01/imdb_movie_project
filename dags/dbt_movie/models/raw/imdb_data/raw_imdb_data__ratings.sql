{{ config(
    materialized='table',
    schema='raw'
) }}

SELECT *,
       CURRENT_TIMESTAMP as _dbt_loaded_at
FROM read_csv_auto('s3://local-lakehouse/ratings.tsv')