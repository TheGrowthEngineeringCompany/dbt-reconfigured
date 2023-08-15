with a as (select 1)
,test_data as (
  select *
  from dbt_reconfiguredtestbot_test_data.test_data
)
,test_case as (
  select 1
    ,array_column
    ,array_has_123
    ,{{ array_contains("array_column", "123") }} as array_contains
  from test_data
)

select 1
from test_case
where array_has_123 <> array_contains
