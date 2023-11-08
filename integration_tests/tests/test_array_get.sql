with a as (select 1)
,test_data as (
  select *
  from dbt_reconfiguredtestbot_test_data.test_data
)
,test_case as (
  select 1
    ,{{ reconfigured.array_get("array_column", 1)}} as array_elem_1_test
    ,array_elem_1
  from test_data
)
select 1
from test_case
where array_elem_1_test <> array_elem_1
