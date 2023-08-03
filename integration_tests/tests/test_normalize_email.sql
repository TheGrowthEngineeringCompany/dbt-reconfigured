{% macro email_test_data() %}
{{ return(adapter.dispatch('email_test_data')()) }}
{% endmacro %}
{% macro bigquery__email_test_data() %}
with d1 as (
  select * from unnest([
    STRUCT('a@a.a' as input, 'a@a.a' as expected),
    ('FOO@bar.IO', 'foo@bar.io'),
    (null, null),
    ('not an email', null),
    ('almost@email', null)
  ])
), d2 as (
  select * from unnest([
    STRUCT(1 as input, cast(null as string) as expected)
  ])
),
{% endmacro %}

{% macro redshift__email_test_data() %}
with d1 as (
  select 'a@a.a' as input, 'a@a.a' as expected
  union all
  select 'FOO@bar.IO', 'foo@bar.io'
  union all
  select null, null
  union all
  select 'not an email', null
  union all
  select 'almost@email', null
), d2 as (
  select 1 as input, cast(null as text) as expected
),
{% endmacro %}

{{ email_test_data() }}

tst as (
  select
    {{ normalize_email('input') }} = expected as success
  from d1
  union all
  select
    {{ normalize_email('input') }} = expected as success
  from d2
)

select 1
from tst
where success is false
