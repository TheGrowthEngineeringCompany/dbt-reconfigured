with test_data as (
  select
    cast('niko@reconfigured.io' as {{ dbt.type_string() }}) as input,
    cast('reconfigured.io' as {{ dbt.type_string() }}) as expected
)
, test as (
  select {{ reconfigured.parse_email_domain("input") }} = expected as case_true
  from test_data
)

select *
from test
where not case_true