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
  select 1 as input, cast(null as {{ type_string() }}) as expected
),

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
where not success
