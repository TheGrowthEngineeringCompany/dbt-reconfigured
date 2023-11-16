with
tst as (
  select
    id,
    {{ reconfigured.most_recent('v', 'o') }} as most_recent
  from {{ ref('recency_data') }}
  group by 1
),
expected as (
  select 1 as id, 'b' as ev
  union all
  select 2 as id, 'a' as ev
)

select *
from tst
join expected on tst.id = expected.id
where tst.most_recent <> expected.ev
