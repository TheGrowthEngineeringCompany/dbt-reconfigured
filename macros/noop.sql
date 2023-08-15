{%- macro noop(value) -%}
{{ return(adapter.dispatch('noop')(value)) }}
{%- endmacro -%}

{%- macro default__noop(value) -%}
{{ exceptions.raise_compiler_error("Unsupported target database") }}
{%- endmacro -%}

{%- macro redshift__noop(value) -%}
{%- endmacro -%}

{%- macro snowflake__noop(value) -%}
{%- endmacro -%}

{%- macro bigquery__noop(value) -%}
{%- endmacro -%}