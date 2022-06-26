FROM debian:bullseye-slim as router
RUN  apt-get update -q && DEBIAN_FRONTEND=non-interactive apt-get install -qy iproute2 && rm -rf /var/lib/apt/lists/*
COPY entrypoint.sh /usr/local/sbin/entrypoint.sh
ENV VOL_FILE=""
ENV ROUTE6_NET=""
ENV ROUTE6_GW=""
ENV ROUTE4_NET=""
ENV ROUTE4_GW=""
ENTRYPOINT ["entrypoint.sh"]
CMD ["--help"]

FROM debian:bullseye-slim as router-debug
RUN  apt-get update -q && DEBIAN_FRONTEND=non-interactive apt-get install -qy iperf3 iputils-ping iproute2 tshark && rm -rf /var/lib/apt/lists/*
ENTRYPOINT ["sleep"]
CMD ["infinity"]
