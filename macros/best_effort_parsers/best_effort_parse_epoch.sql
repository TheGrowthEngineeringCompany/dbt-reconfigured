{% macro best_effort_parse_epoch(text) %}
{{ return(adapter.dispatch('best_effort_parse_epoch', 'reconfigured')(text)) }}
{% endmacro %}

{% macro default__best_effort_parse_epoch(text) %}
{{ exceptions.raise_compiler_error("Unsupported target database") }}
{% endmacro %}

{% macro redshift__best_effort_parse_epoch(text) %}
CASE WHEN REGEXP_INSTR({{ text }}, '^\\d+$')
THEN (timestamp 'epoch' + {{ text }}::text::integer * interval '1 second')
ELSE CAST(NULL AS TIMESTAMP) END
{% endmacro %}

{% macro snowflake__best_effort_parse_epoch(text) %}
CASE WHEN {{ safe_cast(text, api.Column.translate_type('integer')) }} IS NOT NULL
THEN TRY_TO_TIMESTAMP({{ text }})
ELSE CAST(NULL AS TIMESTAMP) END
{% endmacro %}

{% macro bigquery__best_effort_parse_epoch(text) %}
CASE WHEN {{ safe_cast(text, api.Column.translate_type('integer')) }} IS NOT NULL
THEN TIMESTAMP_SECONDS(CAST({{ text }} AS INT64))
ELSE CAST(NULL AS TIMESTAMP) END
{% endmacro %}
