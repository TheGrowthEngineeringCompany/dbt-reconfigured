{% macro parse_website_domain(text) %}
{{ return(adapter.dispatch('parse_website_domain', 'reconfigured') (text)) }}
{% endmacro %}

{% macro default__parse_website_domain() %}
exceptions.raise_compiler_error("Unsupported target database")
{% endmacro %}

{% macro snowflake__parse_website_domain(text) %}
TRIM(LOWER(REGEXP_SUBSTR(
  CAST({{ text }} AS STRING),
  '((http(s)?):\\/\\/)?(www\\.)?([a-zA-Z0-9@:%._\\-\\+~#=]{2,256}\\.[a-z]{2,6})\\b([-a-zA-Z0-9@:%_\\+.~#?&//=]*)',
  1, 1, 'i', 5
)))
{% endmacro %}
{% macro bigquery__parse_website_domain(text) %}
TRIM(LOWER(REGEXP_EXTRACT(
  CAST({{ text }} AS STRING),
  r'(?:https?:\/\/)?(?:www\.)?([a-zA-Z0-9@:%._\-\+~#=]{2,256}\.[a-z]{2,6})\b[-a-zA-Z0-9@:%_\+.~#?&//=]*'
)))
{% endmacro %}

{% macro redshift__parse_website_domain(text) %}
TRIM(LOWER(REGEXP_REPLACE(
  {{ text }}::TEXT,
  '((http(s)?):\\/\\/)?(www\\.)?([a-zA-Z0-9@:%._\\-\\+~#=]{2,256}\\.[a-z]{2,6})\\b([-a-zA-Z0-9@:%_\\+.~#?&//=]*)',
  '$5'
)))
{% endmacro %}