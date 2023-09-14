{%- macro py_to_sql_type_map() -%}
{{ return({
  'string': dbt.type_string,
  'bigint': dbt.type_bigint,
  'int': dbt.type_int,
  'bool': dbt.type_boolean,
  'float': dbt.type_float,
  'numeric': dbt.type_numeric,
  'timestamp': dbt.type_timestamp
}) }}
{%- endmacro -%}

{%- macro py_to_sql_type(t) -%}
{{ reconfigured.py_to_sql_type_map()[t]() }}
{%- endmacro -%}

{%- macro py_to_sql_infer_type(value) -%}
{%- if value is string -%}
{{ return('string') }}
{%- elif value is integer -%}
{{ return('bigint') }}
{%- elif value is float -%}
{{ return('float') }}
{%- else -%}
{{ exceptions.raise_compiler_error("Could not infer type of input") }}
{%- endif -%}
{%- endmacro -%}

{%- macro py_to_sql_get_or_infer_type(value, t=None) -%}
{{ return(t or reconfigured.py_to_sql_infer_type(value))}}
{%- endmacro -%}

{%- macro py_to_sql(value, t=None) -%}
{{ return(adapter.dispatch('py_to_sql', 'reconfigured')(value, reconfigured.py_to_sql_get_or_infer_type(value, t))) }}
{%- endmacro -%}

{%- macro py_to_sql_literal(value, t) -%}
{%- if t == 'int' -%}
{{ value|int }}
{%- elif t == 'bigint' -%}
{{ value|int }}
{%- elif t == 'float' -%}
{{ value|float }}
{%- else -%}
{{ dbt.string_literal(value) }}
{%- endif -%}
{%- endmacro -%}

{%- macro default__py_to_sql(value, t) -%}
CAST({{ reconfigured.py_to_sql_literal(value, t) }} AS {{ reconfigured.py_to_sql_type(t) }})
{%- endmacro -%}
