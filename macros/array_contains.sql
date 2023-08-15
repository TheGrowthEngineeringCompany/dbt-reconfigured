{%- macro array_contains(arr, val) -%}
{{ return(adapter.dispatch('array_contains')(arr, val)) }}
{%- endmacro -%}

{%- macro default__array_contains(t) -%}
{{ exceptions.raise_compiler_error("Unsupported target database") }}
{%- endmacro -%}

{%- macro redshift__array_contains(arr, val) -%}
(
  with numbers as (
    select generated_number::int as ordinal
    from ({{ dbt_utils.generate_series(1000) }})
  )
  , unnested as (
    select {{ arr }}[numbers.ordinal]
    from numbers
    where numbers.ordinal <= get_array_length({{ arr }})
    and {{ arr }}[numbers.ordinal] = {{ val }}
  )
  select count(1) >= 1
  from unnested
)
{%- endmacro -%}

{%- macro snowflake__array_contains(arr, val) -%}
ARRAY_CONTAINS({{ val }}::variant, {{ arr }})
{%- endmacro -%}

{%- macro bigquery__array_contains(arr, val) -%}
(SELECT COUNT(1) FROM UNNEST({{ arr }}) arr WHERE arr = {{ val }}) >= 1
{%- endmacro -%}