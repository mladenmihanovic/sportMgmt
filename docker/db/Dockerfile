FROM postgres:16-alpine

ENV POSTGRES_USER=admin
ENV POSTGRES_PASSWORD=admin
ENV POSTGRES_DB=sport-mgmt

COPY init.sql /docker-entrypoint-initdb.d/

EXPOSE 5432