{% macro most_recent(col, recency_col) -%}
{{ return(adapter.dispatch('most_recent', 'reconfigured')(col, recency_col)) }}
{%- endmacro %}

{% macro default__most_recent(col, recency_col) -%}
{{ exceptions.raise_compiler_error("Unsupported target database") }}
{%- endmacro %}

{% macro bigquery__most_recent(col, recency_col) -%}
ARRAY_AGG({{ col }} IGNORE NULLS ORDER BY {{ recency_col }} LIMIT 1)[SAFE_OFFSET(0)]
{%- endmacro %}

{% macro snowflake__most_recent(col, recency_col) -%}
MAX_BY({{ col }}, {{ recency_col }})
{%- endmacro %}

{% macro redshift__most_recent(col, recency_col) -%}
SPLIT_PART(LISTAGG({{ col }}::varchar, ', ') WITHIN GROUP (ORDER BY {{ recency_col }} DESC), ', ', 1)
{%- endmacro %}
