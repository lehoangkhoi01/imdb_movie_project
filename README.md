# imdb_movie
This is my demo project in the purpose of learning Data Engineering. 
### Goals
Apply Airflow, dbt to build ELT pipelines and data warehouse

### Scenarios
Suppose we have a back-end storage containing many csv files related to movie ratings on IMDB. We want to transfer these data into data warehouse for analytic purpose. Provide a solution to archive it.

### Components
- We will use [MinIO](https://www.min.io/) as the back-end storage since it's similiar to Amazon S3. 
- The data files can be downloaded from [imdb non-commercial datasets](https://developer.imdb.com/non-commercial-datasets/)
- [dbt](https://docs.getdbt.com/docs/introduction) as the transformation tool
- [Airflow](https://airflow.apache.org/) to manage workflow for pipelines
- [DuckDB](https://docs.getdbt.com/docs/core/connect-data-platform/duckdb-setup) will take the role of Data Warehouse
- [Docker](https://www.docker.com/) setup for our needed environments

### Project structure
- docker compose files have many setup for MinIO and Airflow environments
- `manage-lakehouse.sh` bash file to run the docker compose 
- `dags` folder contain 3 main parts: 
	- `dbt_movie` directory: Contain dbt project setup, especially `models` which will be turned to tables and views in data warehouse. Follow [this guide](https://docs.getdbt.com/best-practices/how-we-structure/1-guide-overview) for more details
	- `custom_operator`: Contain custom airflow operator for dbt
	- `dbt_dg.py`: DAG logic

### Guide
->> **Prerequisite** 


- Must have docker installed
- Install dbt-core, dbt-duckdb in python environment (for easy local testing)

**Step**
1. Run `./manage-lakehouse.sh start` to start docker containers
2. Now, we have **MinIO** storage ready in your local machine
3. Access to MinIO UI by your local host (check ports in docker compose file), you will see there's already existed bucket named `local-lakehouse` (I have created it in the command in docker compose file)
4. Upload csv data files to MinIO (downloaded to your laptop from imdb datasets site). Now we have our back-end storage setup with many CSV files
5. Go to `/dags/dbt_movie` directory, run `dbt debug` to verify the dbt and duckdb  setup are ready. Examine more in `dbt_project.yml` and `profiles.yml` 
6. Optional: Run `dbt run` to verify the dbt work perfectly before moving it to Airflow
