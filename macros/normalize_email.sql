{%- macro normalize_email(text) -%}
{{ return(adapter.dispatch('normalize_email', 'reconfigured') (text)) }}
{%- endmacro -%}

{%- macro default__normalize_email(t) -%}
{{ exceptions.raise_compiler_error("Unsupported target database") }}
{%- endmacro -%}

{%- macro redshift__normalize_email(text) -%}
CASE
  WHEN REGEXP_INSTR(
    TRIM(CAST({{ text }} as {{ dbt.type_string() }})),
    '^[a-zA-Z0-9_.+\\-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9\\-]+$'
  ) THEN REGEXP_REPLACE(LOWER(TRIM(CAST({{ text }} as {{ dbt.type_string() }}))), '\\+[\\d\\D]*\\@', '@')
  ELSE NULL
END
{%- endmacro -%}

{%- macro snowflake__normalize_email(text) -%}
CASE
  WHEN REGEXP_LIKE(
    TRIM(CAST({{ text }} as {{ dbt.type_string() }})),
    '^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9\\-]+$'
  ) THEN REGEXP_REPLACE(LOWER(TRIM(CAST({{ text }} as {{ dbt.type_string() }}))), '\\+[\\d\\D]*\\@', '@')
  ELSE NULL
END
{%- endmacro -%}

{%- macro bigquery__normalize_email(text) -%}
CASE
  WHEN REGEXP_CONTAINS(
    TRIM(CAST({{ text }} as {{ dbt.type_string() }})),
    r'^[a-zA-Z0-9_.+\-]+@[a-zA-Z0-9\-]+\.[a-zA-Z0-9\-]+$'
  ) THEN REGEXP_REPLACE(LOWER(TRIM(CAST({{ text }} as {{ dbt.type_string() }}))), r'\+[\d\D]*\@', '@')
  ELSE NULL
END
{%- endmacro -%}

