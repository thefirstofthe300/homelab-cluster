FROM ubuntu:latest as builder

RUN apt-get update && apt-get install -y curl binutils tar

RUN curl -L -O https://github.com/tensorchord/pgvecto.rs/releases/download/v0.1.11/vectors-pg15-v0.1.11-x86_64-unknown-linux-gnu.deb \
    && ar -xv vectors-pg15-v0.1.11-x86_64-unknown-linux-gnu.deb \
    && tar zxf data.tar.gz

FROM registry.developers.crunchydata.com/crunchydata/crunchy-postgres:ubi8-15.5-0

COPY --from=builder ./usr/lib/postgresql/15/lib/vectors.so /usr/pgsql-15/lib
COPY --from=builder ./usr/share/postgresql/15/extension/vectors--0.1.1.sql /usr/pgsql-15/share/extension/vectors--0.1.1.sql
COPY --from=builder ./usr/share/postgresql/15/extension/vectors.control /usr/pgsql-15/share/extension

WORKDIR /
USER 26