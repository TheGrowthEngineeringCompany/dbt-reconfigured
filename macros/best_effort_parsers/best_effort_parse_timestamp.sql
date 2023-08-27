{% macro best_effort_parse_timestamp(text) %}
{{ return(adapter.dispatch('best_effort_parse_timestamp')(text)) }}
{% endmacro %}

{% macro default__best_effort_parse_timestamp(t) %}
{{ exceptions.raise_compiler_error("Unsupported target database") }}
{% endmacro %}

{% macro redshift__best_effort_parse_timestamp(text) %}
CASE WHEN {{ maybe_is_iso8601(text) }}
THEN CAST({{ text }} AS TIMESTAMP)
ELSE ({{ best_effort_parse_epoch(text) }}) END
{% endmacro %}

{% macro snowflake__best_effort_parse_timestamp(text) %}
TRY_TO_TIMESTAMP({{ text }})
{% endmacro %}

{% macro bigquery__best_effort_parse_timestamp(text) %}
CASE WHEN {{ safe_cast(text, api.Column.translate_type('timestamp')) }} IS NOT NULL
THEN TIMESTAMP({{ text }})
ELSE ({{ best_effort_parse_epoch(text) }}) END
{% endmacro %}
