#!/usr/bin/env bash

dbt clean --project-dir ./integration_tests
dbt deps --project-dir ./integration_tests

dbt run --project-dir ./integration_tests --profile reconfigured_test_bigquery
dbt test --project-dir ./integration_tests --profile reconfigured_test_bigquery

dbt run --project-dir ./integration_tests --profile reconfigured_test_redshift
dbt test --project-dir ./integration_tests --profile reconfigured_test_redshift

dbt run --project-dir ./integration_tests --profile reconfigured_test_snowflake
dbt test --project-dir ./integration_tests --profile reconfigured_test_snowflake
