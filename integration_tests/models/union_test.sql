{{
    config(
        materialized="table",
        schema="test_data"
    )
}}

{{ reconfigured.union_with_id_prefix(
    id_cols=['id', 'another_id'],
    relations=[
      [ref('union_source_1'), 'Source1:'],
      [ref('union_source_2'), 'Source2:'],
    ]
) }}
