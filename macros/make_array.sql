{%- macro make_array(value) -%}
{{ return(adapter.dispatch('make_array', 'reconfigured')(value)) -}}
{%- endmacro -%}

{%- macro default__make_array(t) -%}
{{ exceptions.raise_compiler_error("Unsupported target database") }}
{%- endmacro -%}

{%- macro redshift__make_array(value) -%}
ARRAY(
{%- for v in value -%}
{{ reconfigured.py_to_sql(v) }}
{%- if not loop.last -%}, {% endif-%}
{%- endfor -%}
)
{%- endmacro -%}

{%- macro snowflake__make_array(value) -%}
ARRAY_CONSTRUCT(
{%- for v in value -%}
{{ reconfigured.py_to_sql(v) }}
{%- if not loop.last -%}, {% endif-%}
{%- endfor -%}
)
{%- endmacro -%}

{%- macro bigquery__make_array(value) -%}
[
{%- for v in value -%}
{{ reconfigured.py_to_sql(v) }}
{%- if not loop.last -%}, {% endif-%}
{%- endfor -%}
]
{%- endmacro -%}