FROM python:3.12
ENV PORT=8080

RUN adduser note_api

RUN pip install --upgrade pip

WORKDIR /code

COPY ./requirements.txt /code/requirements.txt

RUN pip3 install -r requirements.txt \
    opentelemetry-api \
    opentelemetry-sdk \
    opentelemetry-instrumentation-fastapi \
    opentelemetry-exporter-gcp-trace \
    opentelemetry-instrumentation-requests

COPY ./note_api /code/note_api

USER note_api

CMD ["bash", "-c", "uvicorn note_api.main:app --host 0.0.0.0 --port ${PORT}"]
