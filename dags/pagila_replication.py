from airflow import DAG
from airflow.providers.airbyte.operators.airbyte import AirbyteTriggerSyncOperator
from airflow.utils.dates import days_ago
from datetime import timedelta

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

with DAG(
    dag_id='pagila_replication',
    default_args=default_args,
    schedule_interval='@daily',
    start_date=days_ago(1),
    catchup=False,
    tags=['pagila', 'snowflake', 'airbyte'],
) as dag:

    sync_pagila = AirbyteTriggerSyncOperator(
        task_id='trigger_pagila_sync',
        airbyte_conn_id='airbyte_conn',
        connection_id='342a1e91-678a-4f99-8616-5514041f3da5',
        asynchronous=False,
        timeout=3600,
        wait_seconds=10
    )