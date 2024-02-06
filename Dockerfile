FROM python:3.11-slim

ENV MINIO_ENDPOINT=""

COPY --chown=${USER} init_bucket .
COPY --chown=${USER} dataset ./dataset

RUN pip install -r requirements.txt

ENTRYPOINT python ./create_and_populate_bucket.py
