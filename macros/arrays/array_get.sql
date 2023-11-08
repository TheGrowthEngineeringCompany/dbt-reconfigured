{% macro array_get(val, i) -%}
{{ return(adapter.dispatch('array_get', 'reconfigured')(val, i)) }}
{% endmacro %}

{% macro default__array_get(val, i) -%}
exceptions.raise_compiler_error("Unsupported target database")
{% endmacro %}

{% macro snowflake__array_get(val, i) -%}
GET({{ val }}, {{ i }})
{% endmacro %}

{% macro bigquery__array_get(val, i) -%}
{{ val }}[SAFE_OFFSET({{ i }})]
{% endmacro %}

{% macro redshift__array_get(val, i) -%}
{{ val }}[{{ i }}]
{% endmacro %}
