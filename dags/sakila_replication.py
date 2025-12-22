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
    dag_id='sakila_replication',
    default_args=default_args,
    schedule_interval='@daily',
    start_date=days_ago(1),
    catchup=False,
    tags=['sakila', 'snowflake', 'airbyte'],
) as dag:

    sync_sakila = AirbyteTriggerSyncOperator(
        task_id='trigger_sakila_sync',
        airbyte_conn_id='airbyte_conn',
        connection_id='0a6fa9ef-4666-42d8-a563-d9c375aa4422',
        asynchronous=False,
        timeout=3600,
        wait_seconds=10
    )