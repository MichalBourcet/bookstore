# Pull base image
FROM python:3.10.4-slim-bullseye AS builder

RUN apt-get update && \
    apt-get install -y libpq-dev gcc

# create virtual environment
RUN python -m venv /opt/venv
# activate
ENV PATH="/opt/venv/bin:$PATH"    

COPY ./requirements.txt .
RUN pip install -r requirements.txt

# operational stage
FROM python:3.10.4-slim-bullseye

RUN apt-get update && \
    apt-get install -y libpq-dev && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /opt/venv /opt/venv    

# Set environment variables
ENV PIP_DISABLE_PIP_VERSION_CHECK 1
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV PATH="/opt/venv/bin:$PATH"

# Set work directory
WORKDIR /code

# Copy project
COPY . .