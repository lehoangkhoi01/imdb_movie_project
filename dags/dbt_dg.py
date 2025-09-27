from datetime import datetime, timedelta
from airflow import DAG
from custom_operator.dbt_operator import DbtCoreOperator
from airflow import settings

DBT_PROJECT_PATH = f"{settings.DAGS_FOLDER}/dbt_movie"

default_args = {
    'owner': 'khoilh',
    'depends_on_past': False,
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=2),
}

with DAG(
        dag_id='dbt_pipeline',
        default_args=default_args,
        description='A DAG to run dbt Core transformations.',
        schedule=timedelta(days=1),
        start_date=datetime(2025, 8, 8),
        catchup=False,
        tags=['dbt', 'data_transformation'],
) as dag:

    # dbt_debug = DbtCoreOperator(
    #     task_id='dbt_debug',
    #     dbt_project_dir=DBT_PROJECT_PATH,
    #     dbt_profiles_dir=DBT_PROJECT_PATH,
    #     dbt_command='debug'
    # )

    dbt_run_marts = DbtCoreOperator(
        task_id='dbt_run_marts',
        dbt_project_dir = DBT_PROJECT_PATH,
        dbt_profiles_dir = DBT_PROJECT_PATH,
        dbt_command='run',
        select='marts'
    )

    dbt_run_inter = DbtCoreOperator(
        task_id='dbt_run_inter',
        dbt_project_dir = DBT_PROJECT_PATH,
        dbt_profiles_dir = DBT_PROJECT_PATH,
        dbt_command='run',
        select='intermediate'
    )

    dbt_run_staging = DbtCoreOperator(
        task_id='dbt_run_staging',
        dbt_project_dir=DBT_PROJECT_PATH,
        dbt_profiles_dir=DBT_PROJECT_PATH,
        dbt_command='run',
        select='staging'
    )

    dbt_run_staging >> dbt_run_inter >> dbt_run_marts
