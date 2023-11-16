{{
    config(
        materialized="table",
        schema="test_data"
    )
}}
select
  {{ reconfigured.make_array([1, 123, 3]) }} array_column,
  true as array_has_123,
  123 as array_elem_1
union all
select
  {{ reconfigured.make_array([3, 4]) }} array_column,
  false as array_has_123,
  4 as array_elem_1
union all
select
  {{ reconfigured.make_array([6, 7, 123, 5]) }} array_column,
  true as array_has_123,
  7 as array_elem_1
