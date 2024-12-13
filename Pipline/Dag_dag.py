from airflow import DAG
from airflow.providers.google.cloud.operators.bigquery import BigQueryInsertJobOperator
from airflow.utils.task_group import TaskGroup
from airflow.utils.dates import days_ago

default_args = {
    'start_date': days_ago(1),
}

with DAG('p1', default_args=default_args, schedule_interval=None) as dag:
    
    with TaskGroup("task_group_1") as task_group_1:
        task_1 = BigQueryInsertJobOperator(
            task_id='Top_10_Users',
            configuration={
                "query": {
                    "query": "{% include 'Top_10_Users.sql' %}",
                    "useLegacySql": False,
                }
            },
        )

        # Assuming no quality check exists, hence no additional tasks are added here.

    task_group_1