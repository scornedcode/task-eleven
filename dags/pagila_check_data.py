from airflow import DAG
from airflow.decorators import task
from airflow.providers.snowflake.hooks.snowflake import SnowflakeHook
from airflow.utils.dates import days_ago
from datetime import timedelta

default_args = {
    'owner': 'airflow',
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

with DAG(
        dag_id='pagila_check_data',
        default_args=default_args,
        schedule_interval=None,
        start_date=days_ago(1),
        catchup=False,
        tags=['check', 'snowflake', 'pagila'],
) as dag:
    @task(task_id='check_table_rows')
    def check_rows(table_name: str, conn_id: str = 'snowflake_conn') -> int:
        hook = SnowflakeHook(snowflake_conn_id=conn_id)

        current_count = hook.get_first(f"SELECT count(*) FROM {table_name}")[0]

        print(f"Table {table_name} has {current_count} rows.")

        if current_count == 0:
            raise ValueError(f"Check failed: Table {table_name} is empty!")

        return current_count

    check_rows(table_name="RAW_DATA.PAGILA.ACTOR")