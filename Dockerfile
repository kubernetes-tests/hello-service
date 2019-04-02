# GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o main
# microk8s.docker build . -t hello
# microk8s.kubectl expose deployment microbot --type=NodePort --port=80 --name=microbot-service

FROM golang:alpine as builder
EXPOSE 3000
COPY src /hello
WORKDIR /hello/main
RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o main .

FROM alpine
COPY --from=builder /hello/main/main /main
CMD ["./main"]