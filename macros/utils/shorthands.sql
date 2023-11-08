{%- macro q(col) -%}
{{ adapter.quote(col) }}
{%- endmacro -%}

{%- macro t(type_) -%}
{{ api.Column.translate_type(type_) }}
{%- endmacro -%}

{%- macro s(val) -%}
{{ dbt.string_literal(val) }}
{%- endmacro -%}

{%- macro st(val, type_) -%}
{{ reconfigured.cast(reconfigured.s(val), reconfigured.t(type_)) }}
{%- endmacro -%}

{%- macro if_incr(stmt, fallback) -%}
{%- if is_incremental() -%}{{ stmt }}{%-else %}{{ fallback }}{% endif -%}
{% endmacro %}

{%- macro min_ts() -%}
CAST('0001-01-01T00:00:00' AS {{ reconfigured.t('timestamp') }})
{%- endmacro -%}

{%- macro max_ts() -%}
CAST('9999-12-31T23:59:59' AS {{ reconfigured.t('timestamp') }})
{%- endmacro -%}

{%- macro run_start_ts() -%}
CAST({{ string_literal(run_started_at.isoformat()) }} AS {{ reconfigured.t('timestamp') }})
{%- endmacro -%}
