# Use a base image for PostgreSQL version 17
ARG PG_MAJOR=16
FROM postgres:$PG_MAJOR

# ARG for PostgreSQL major version to use throughout the Dockerfile
ARG PG_MAJOR

# Install necessary dependencies, including CA certificates
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    postgresql-server-dev-$PG_MAJOR \
    git \
    ca-certificates && \
    update-ca-certificates

# Clone pgvector repository
RUN git clone https://github.com/pgvector/pgvector.git /tmp/pgvector

# Build pgvector extension and clean up
RUN cd /tmp/pgvector && \
    make clean && \
    make OPTFLAGS="" && \
    make install && \
    mkdir /usr/share/doc/pgvector && \
    cp LICENSE README.md /usr/share/doc/pgvector && \
    rm -r /tmp/pgvector && \
    apt-get remove -y build-essential postgresql-server-dev-$PG_MAJOR git && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# Set the default command
CMD ["postgres"]
