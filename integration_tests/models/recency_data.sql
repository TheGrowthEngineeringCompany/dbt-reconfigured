{{
    config(
        materialized="table",
        schema="test_data"
    )
}}

select 1 as id, 1 as o, 'a' as v
union all
select 1 as id, 2 as o, 'b' as v
union all
select 2 as id, 1 as o, 'b' as v
union all
select 2 as id, 2 as o, 'a' as v
