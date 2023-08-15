{{ noop("This doesn't matter") }}

with d as (
  select 1 as input
)
select *
from d
where 1=0
