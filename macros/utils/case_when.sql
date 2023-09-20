{% macro case_when() %}
{{ return(adapter.dispatch('case_when', 'reconfigured')(varargs)) }}
{% endmacro %}

{% macro default__case_when(cases) %}
CASE
{% for case in cases %}{{ case }}{% endfor %}
END
{% endmacro %}

{% macro if_then(when, then) %}
{{ return(adapter.dispatch('if_then', 'reconfigured')(when, then)) }}
{%- endmacro %}

{% macro default__if_then(when, then) %}
  WHEN {{ when }}
  THEN {{ then }}
{% endmacro %}

{% macro else_(then) %}
{{ return(adapter.dispatch('else_', 'reconfigured')(then)) }}
{%- endmacro %}

{% macro default__else_(then) %}
  ELSE {{ then }}
{% endmacro %}
