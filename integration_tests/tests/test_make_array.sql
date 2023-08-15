with d as (
  select
    {{ make_array(["foo", "bar", "baz"]) }} as str_inp,
    {{ make_array([1, 2, 3]) }} as int_inp,
    {{ make_array([1.0, 2.3, 3.5]) }} as flt_inp
)
select *
from d
where 1=0
