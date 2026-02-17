# Astro Runtime Image
FROM quay.io/astronomer/astro-runtime:12.7.1-base

#Switch to user root
USER root

#switched to: /usr/local/airflow/

COPY requirements.txt .
COPY dbt-requirements.txt .

RUN pip config set global.trusted-host "pypi.org pip.astronomer.io pypi.python.org files.pythonhosted.org"
RUN pip install --upgrade pip setuptools
RUN pip install --no-cache-dir --root-user-action=ignore -r requirements.txt

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git

#RUN cd /usr/local/airflow/
RUN python3 -m venv dbt_venv
RUN . dbt_venv/bin/activate
#RUN pip install --no-cache-dir -r dbt-requirements.txt   #
RUN python -m pip install dbt-core
RUN python -m pip install dbt-snowflake
RUN python -m pip install dbt-databricks
RUN deactivate

ENV AIRFLOW__TEST_ENV="Enabled"

# Switch to user astro
USER astro

# Copy astro directory from local to docker container as user astro
COPY --chown=astro:0 . .
