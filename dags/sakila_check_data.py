from airflow import DAG
from airflow.providers.snowflake.operators.snowflake import SnowflakeOperator
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
    dag_id='sakila_check_data',
    default_args=default_args,
    description='check data of Sakila in Snowflake',
    schedule_interval=None,
    start_date=days_ago(1),
    catchup=False,
    tags=['check', 'snowflake', 'sakila'],
) as dag:

    check_sakila = SnowflakeOperator(
        task_id='sakila_check_rows',
        snowflake_conn_id='snowflake_conn',
        sql='SELECT count(*) FROM RAW_DATA.SAKILA.ACTOR HAVING count(*) > 0;',
        warehouse='AIRBYTE_WH',
        database='RAW_DATA',
        role='DEV_ROLE'
    )