FROM golang:1.17 as builder

WORKDIR /build

COPY . .
RUN export GO111MODULE=on
RUN export GOPROXY=https://goproxy.io,direct
RUN export GOPRIVATE=gitee.com
RUN go mod tidy
RUN build -o main main.go

FROM alpine
WORKDIR /build
COPY --from=builder /build/main /build/main

CMD ["./main"]