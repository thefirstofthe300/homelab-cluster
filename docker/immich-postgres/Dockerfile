FROM ubuntu:latest as builder

RUN apt-get update && apt-get install -y curl binutils unzip

RUN curl -L -o vectors.zip https://github.com/tensorchord/pgvecto.rs/releases/download/v0.2.1/vectors-pg15_x86_64-unknown-linux-gnu_0.2.1.zip \
    && unzip -d vectors vectors.zip

FROM registry.developers.crunchydata.com/crunchydata/crunchy-postgres:ubi8-15.6-0

COPY --from=builder ./vectors/vectors.so /usr/pgsql-15/lib
COPY --from=builder ./vectors/vectors*.sql /usr/pgsql-15/share/extension/
COPY --from=builder ./vectors/vectors.control /usr/pgsql-15/share/extension

WORKDIR /
USER 26