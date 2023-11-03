{{
    config(
        materialized="table",
        schema="test_data"
    )
}}

select
  2 as id,
  1 as another_id,
  'Foo 2-2' as value_1,
  'Bar 2-2' as value_2
union all
select
  3 as id,
  2 as another_id,
  'Foo 2-3' as value_1,
  null as value_2
union all
select
  4 as id,
  2 as another_id,
  'Foo 2-4' as value_1,
  'Bar 2-4' as value_2
