FROM golang:1.21-bookworm AS builder

WORKDIR /go/src
COPY . ./
RUN go build -o prometheus-dnssec-exporter

FROM debian:bookworm-slim AS runner

COPY --from=builder /go/src/prometheus-dnssec-exporter /usr/local/bin/prometheus-dnssec-exporter

RUN groupadd -r -g 9999 mangadex && useradd -u 9999 -r -g 9999 mangadex
USER mangadex
WORKDIR /tmp

COPY docker-entrypoint.sh /docker-entrypoint.sh
CMD ["/docker-entrypoint.sh"]
