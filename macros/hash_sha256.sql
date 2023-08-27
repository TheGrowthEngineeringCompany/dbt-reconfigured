{% macro hash_sha256(text) %}
{{ return(adapter.dispatch('hash_sha256', 'reconfigured')(text)) }}
{% endmacro %}

{% macro default__hash_sha256(t) %}
{{ exceptions.raise_compiler_error("Unsupported target database") }}
{% endmacro %}

{% macro redshift__hash_sha256(text) %}
SHA2(CAST({{ text }} as {{ dbt.type_string() }}), 256)
{% endmacro %}

{% macro snowflake__hash_sha256(text) %}
SHA2(CAST({{ text }} as {{ dbt.type_string() }}), 256)
{% endmacro %}

{% macro bigquery__hash_sha256(text) %}
TO_HEX(SHA256(CAST({{ text }} as {{ dbt.type_string() }})))
{% endmacro %}
