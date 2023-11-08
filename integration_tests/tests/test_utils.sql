with date_tst as (
  select
    {{ reconfigured.st("2023-11-11", "date") }} as test,
    date({{ reconfigured.s("2023-11-11") }}) as expected,
    {{ reconfigured.min_ts() }} as mits,
    {{ reconfigured.max_ts() }} as mats,
    {{ reconfigured.run_start_ts() }} as rsts
)

select *
from date_tst
where test <> expected


