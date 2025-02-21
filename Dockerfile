FROM debian:bookworm

RUN apt update && \
    apt full-upgrade -y && \
    apt autoremove --purge -y && \
    apt install build-essential libssl-dev cmake git -y
RUN git clone https://github.com/zouxianyu/query-pdb --depth 1 --single-branch src && cd src && mkdir build && cd build && \
    cmake .. && cmake --build . --target query_pdb_server -j$(nproc)

FROM debian:bookworm
COPY --from=0 /src/build/server/query_pdb_server /usr/bin/query_pdb_server

ADD docker-entrypoint.sh /usr/bin/docker-entrypoint.sh
RUN apt update && \
    apt full-upgrade -y && \
    apt autoremove --purge -y && \
    apt install ca-certificates -y

FROM scratch
COPY --from=1 / /

ENV BIND_ADDR=0.0.0.0
ENV BIND_PORT=8080
ENV DATA_PATH=data

STOPSIGNAL SIGKILL
ENTRYPOINT ["docker-entrypoint.sh"]
CMD []
