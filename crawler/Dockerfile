FROM golang:1.13.1

WORKDIR /go
RUN git clone https://github.com/italia/developers-italia-backend.git
WORKDIR /go/developers-italia-backend/crawler
RUN make

COPY ./config.toml ./
COPY ./domains.yml ./
COPY ./wait-for-it.sh ./
COPY ./start.sh ./
RUN mkdir -p /tmp/crawler/output

