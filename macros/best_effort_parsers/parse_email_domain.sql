{% macro parse_email_domain(text) %}
{{ return(adapter.dispatch('parse_email_domain', 'reconfigured') (text)) }}
{% endmacro %}

{% macro default__parse_email_domain() %}
exceptions.raise_compiler_error("Unsupported target database")
{% endmacro %}

{% macro snowflake__parse_email_domain(text) %}
TRIM(LOWER(REGEXP_SUBSTR(
  CAST({{ text }} AS STRING),
  '.*@([-a-zA-Z0-9\.]*)',
  1, 1, 'i', 1
)))
{% endmacro %}
{% macro bigquery__parse_email_domain(text) %}
TRIM(LOWER(REGEXP_EXTRACT(
  CAST({{ text }} AS STRING),
  r'.*@([-a-zA-Z0-9\.]*)'
)))
{% endmacro %}

{% macro redshift__parse_email_domain(text) %}
TRIM(LOWER(REGEXP_REPLACE(
  {{ text }}::TEXT,
  '.*@([-a-zA-Z0-9\.]*)',
  '$1'
)))
{% endmacro %}