with d as (
  select 1 as inp, 'one or smaller' as expected
  union all
  select 2 as inp, 'is two' as expected
  union all
  select 3 as inp, 'big number' as expected
  union all
  select 4 as inp, 'big number' as expected
),
test as (
  select
    {{
      reconfigured.case_when(
        reconfigured.if_then("inp <= 1", "'one or smaller'"),
        reconfigured.if_then("inp = 2", "'is two'"),
        reconfigured.else_("'big number'")
      )
    }} as tst,
    expected
  from d
)

select *
from test
where tst <> expected
