
{% macro maybe_is_iso8601(text) %}
{{ return(adapter.dispatch('maybe_is_iso8601', 'reconfigured')(text)) }}
{% endmacro %}

{% macro default__maybe_is_iso8601(t) %}
{{ exceptions.raise_compiler_error("Unsupported target database") }}
{% endmacro %}

{% macro redshift__maybe_is_iso8601(text) %}
REGEXP_INSTR({{ text }}, '(\\d{4})-(\\d{2})-(\\d{2})T(\\d{2})\\:(\\d{2})\\:(\\d{2})(([+-](\\d{2})\\:(\\d{2}))|z|Z)?')
{% endmacro %}

{% macro snowflake__maybe_is_iso8601(text) %}
REGEXP_LIKE({{ text }}, '(\\d{4})-(\\d{2})-(\\d{2})T(\\d{2})\\:(\\d{2})\\:(\\d{2})(([+-](\\d{2})\\:(\\d{2}))|z|Z)?')
{% endmacro %}

{% macro bigquery__maybe_is_iso8601(text) %}
REGEXP_CONTAINS({{ text }}, r'(\d{4})-(\d{2})-(\d{2})T(\d{2})\:(\d{2})\:(\d{2})(([+-](\d{2})\:(\d{2}))|z|Z)?')
{% endmacro %}
