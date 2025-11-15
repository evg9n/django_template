FROM python:3.12-alpine

RUN pip install poetry

RUN poetry config virtualenvs.create false

WORKDIR /app

USER root

RUN apk add --no-cache libpq postgresql-dev build-base

COPY pyproject.toml poetry.lock* ./

RUN poetry install --no-interaction --no-ansi --no-root

COPY . .

EXPOSE 8000

CMD gunicorn its_smeta.wsgi:application --bind 0.0.0.0:8000
