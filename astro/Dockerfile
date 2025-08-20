FROM quay.io/astronomer/astro-runtime:11.4.0

# Astro Runtime Image
FROM quay.io/astronomer/astro-runtime:8.8.0-base

# Switch to user root
USER root
COPY requirements.txt .
RUN pip config set global.trusted-host "pypi.org pip.astronomer.io pypi.python.org"
RUN pip install --upgrade pip
RUN pip install --no-cache-dir --root-user-action=ignore -r requirements.txt
RUN python3 -m venv /usr/local/airflow/dbt_venv
RUN . /usr/local/airflow/dbt_venv/bin/activate
RUN python -m pip install dbt-core
RUN python -m pip install dbt-snowflake

# Switch to user astro
USER astro

# Copy astro directory from local to docker container as user astro
COPY --chown=astro:0 . .
