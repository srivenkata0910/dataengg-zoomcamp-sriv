{{
    config(
        materialized='table'
    )
}}

select * from {{ source('jaffle_shop', 'orders') }}