{{
    config (
        materialized = 'table'
    )
}}

WITH

fct_reviews AS (
    SELECT
        *
    FROM
        {{ ref('fct_reviews') }}
),

full_moon_dates AS (
    SELECT
        *
    FROM
        {{ ref('seed_full_moon_dates') }}
)

SELECT
    R.*,
    CASE
        WHEN FM.full_moon_date IS NULL THEN 'not full moon'
        ELSE 'full moon'
    END AS is_full_moon
FROM
    fct_reviews R
LEFT JOIN
    full_moon_dates FM
    ON TO_DATE(R.review_date) = DATEADD(DAY, 1, FM.full_moon_date)