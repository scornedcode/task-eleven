from datetime import datetime
from airflow import DAG
from airflow.providers.common.sql.operators.sql import SQLExecuteQueryOperator
from pathes import SCRIPTS_PATH

default_args = {
    'owner': 'airflow',
    'start_date': datetime(2024, 1, 1),
}

with DAG(
    dag_id='init_sakila_db',
    default_args=default_args,
    schedule=None,
    catchup=False,
    template_searchpath=[SCRIPTS_PATH],
    tags=['sakila', 'setup']
) as dag:

    create_schema = SQLExecuteQueryOperator(
        task_id='create_schema',
        conn_id='mysql_sakila_conn',
        sql='sakila-schema.sql'
    )

    populate_data = SQLExecuteQueryOperator(
        task_id='populate_data',
        conn_id='mysql_sakila_conn',
        sql='sakila-data.sql'
    )

    create_schema >> populate_data