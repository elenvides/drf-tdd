# pull official base image
FROM python:3.11.2-slim-buster

# set working directory
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# add app
COPY . .

# install system dependencies
RUN apt-get update \
  && apt-get -y install gcc postgresql netcat \
  && apt-get clean

# install dependencies
RUN apt-get update \
    && pip install --upgrade pip \
    && pip install --upgrade setuptools \
    && pip install pipenv \
    && pip install watchdog


RUN pipenv sync --dev --system

# copy entrypoint.sh
COPY /app/entrypoint.sh /usr/src/app/entrypoint.sh
RUN chmod +x /usr/src/app/entrypoint.sh

# run entrypoint.sh
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
