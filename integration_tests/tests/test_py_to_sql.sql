with d as (
  select
    {{ reconfigured.py_to_sql('foo') }} as str_inp,
    {{ reconfigured.py_to_sql(1) }} as int_inp,
    {{ reconfigured.py_to_sql(1.0) }} as flt_inp,
    {{ reconfigured.py_to_sql(1.0, 'int') }} as flt_to_int_inp,
    {{ reconfigured.py_to_sql('2022-06-06T09:30:38', 'timestamp') }} as dt_inp,
    {{ reconfigured.py_to_sql(20.34, 'numeric') }} as numeric_inp
  /*
  This gets compiled to following in BigQuery
  select
    CAST('foo' AS STRING) as str_inp,
    CAST(1 AS bigint) as int_inp,
    CAST(1.0 AS FLOAT64) as flt_inp,
    CAST(1 AS INT64) as flt_to_int_inp,
    CAST('2022-06-06T09:30:38' AS TIMESTAMP) as dt_inp,
    CAST('20.34' AS numeric) as numeric_inp
  */
)
select *
from d
where 1=0
