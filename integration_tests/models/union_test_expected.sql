{{
    config(
        materialized="table",
        schema="test_data"
    )
}}

select
  'Source1:1' as id,
  'Source1:1' as another_id,
  'Foo 1-1' as value_1,
  'Bar 1-1' as value_2
union all
select
  'Source1:2' as id,
  'Source1:1' as another_id,
  'Foo 1-2' as value_1,
  null as value_2
union all
select
  'Source1:3'as id,
  'Source1:2' as another_id,
  'Foo 1-3' as value_1,
  'Bar 1-3' as value_2
union all
select
  'Source2:2' as id,
  'Source2:1' as another_id,
  'Foo 2-2' as value_1,
  'Bar 2-2' as value_2
union all
select
  'Source2:3' as id,
  'Source2:2' as another_id,
  'Foo 2-3' as value_1,
  null as value_2
union all
select
  'Source2:4' as id,
  'Source2:2' as another_id,
  'Foo 2-4' as value_1,
  'Bar 2-4' as value_2
