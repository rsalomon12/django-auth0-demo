FROM python:3.7-alpine
MAINTAINER Rogelio ATX

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .build-deps \
    gcc libc-dev linux-headers python3-dev musl-dev libffi-dev libressl-dev
RUN apk del libressl-dev
RUN apk add openssl-dev
RUN pip install cryptography==2.9.2
RUN apk del openssl-dev
RUN apk add libressl-dev postgresql-dev
RUN pip install --no-cache-dir -r requirements.txt
RUN apk del .build-deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN adduser -D user
USER user
