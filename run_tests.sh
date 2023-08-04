#!/usr/bin/env bash

dbt clean --project-dir ./integration_tests
dbt test --project-dir ./integration_tests --profile reconfigured_test_redshift
dbt test --project-dir ./integration_tests --profile reconfigured_test_bigquery
dbt test --project-dir ./integration_tests --profile reconfigured_test_snowflake
