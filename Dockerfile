FROM golang:1.8 as goimage
WORKDIR /go/src/restapi
RUN pwd
COPY . .
ENV GOOS=linux
ENV CGO_ENABLED=0
RUN ls
RUN go get
RUN go build -o restapi
RUN ls

FROM alpine:3.6 as baseimagealp

RUN apk add --no-cache bash
ENV WORK_DIR=/docker/bin
WORKDIR $WORK_DIR
COPY --from=goimage /go/src/restapi ./
RUN ls
ENTRYPOINT ["./restapi"]
EXPOSE 8080
