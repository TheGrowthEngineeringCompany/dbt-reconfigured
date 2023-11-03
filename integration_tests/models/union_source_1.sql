{{
    config(
        materialized="table",
        schema="test_data"
    )
}}

select
  1 as id,
  1 as another_id,
  'Foo 1-1' as value_1,
  'Bar 1-1' as value_2
union all
select
  2 as id,
  1 as another_id,
  'Foo 1-2' as value_1,
  null as value_2
union all
select
  3 as id,
  2 as another_id,
  'Foo 1-3' as value_1,
  'Bar 1-3' as value_2
