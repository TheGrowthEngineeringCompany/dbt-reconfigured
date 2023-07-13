with d1 as (
  select * from unnest([
    STRUCT('a@a.a' as input, 'a@a.a' as expected),
    ("FOO@bar.IO", 'foo@bar.io'),
    (null, null),
    ('not an email', null),
    ('almost@email', null)
  ])
), d2 as (
  select * from unnest([
    STRUCT(1 as input, cast(null as string) as expected)
  ])
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
where success is false
