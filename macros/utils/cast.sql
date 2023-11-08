{% macro cast(val, type_) -%}
{{ return(adapter.dispatch('cast', 'reconfigured')(val, type_)) }}
{% endmacro %}

{% macro default__cast(val, type_) -%}
CAST({{ val }} AS {{ reconfigured.t(type_) }})
{% endmacro %}
