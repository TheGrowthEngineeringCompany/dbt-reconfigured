with d as (
  select
    cast('1693155990' as {{ api.Column.translate_type('string') }}) as input,
    cast('2023-08-27T17:06:30Z' as timestamp) expected
  union all
  select
    cast('2023-08-27T16:29:54Z'  as {{ api.Column.translate_type('string') }}) as input,
    cast('2023-08-27T16:29:54Z' as timestamp) as expected
  union all
  select
    cast('invalid ts' as {{ api.Column.translate_type('string') }}) as input,
    cast(null as timestamp) as expected
), test as (
  select
    {{ reconfigured.best_effort_parse_timestamp("d.input") }} as input,
    d.expected
    from d
)

select *
from test
where   not (
    input = expected
    or (input is null and expected is null)
  )
