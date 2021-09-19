FROM python:3.7-alpine
ENV PYTHONUNBUFFERED=1
RUN mkdir /app
WORKDIR /app
COPY ./requirements.txt /requirements.txt
# RUN apk update
# RUN rm -rf /var/cache/apk/* && \
#                 rm -rf /tmp/*
# RUN apk update \
#                 && apk add --update --no-cache postgresql-client 
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
      gcc libc-dev linux-headers postgresql-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps
COPY . /app/
#create user to run apps in the docker
RUN adduser -D user
#switch to the user
USER user