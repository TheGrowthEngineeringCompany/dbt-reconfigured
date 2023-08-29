with d1 as (
    select
        cast('asdfasfd' as {{ dbt.type_string() }}) as inp,
        cast(
            '389205904d6c7bb83fc676513911226f2be25bf1465616bb9b29587100ab1414'
            as {{ dbt.type_string() }}
        ) as expected
),

d2 as (
    select
        123 as inp,
        cast(
            'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3'
            as {{ dbt.type_string() }}
        ) as expected
),

tst as (
    select
        {{ reconfigured.hash_sha256('inp') }} = expected as success
    from d1
    union all
    select
        {{ reconfigured.hash_sha256('inp') }} = expected as success
    from d2
)

select 1
from tst
where not success
