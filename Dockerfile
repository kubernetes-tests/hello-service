# GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o main
# microk8s.docker build . -t hello
# microk8s.kubectl expose deployment microbot --type=NodePort --port=80 --name=microbot-service

FROM golang:alpine as builder
EXPOSE 3000
COPY src .
RUN cd main && \
CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o main .
RUN ls && echo $PWD
FROM scratch
ADD ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /main/main /
RUN ls
CMD ["./main"]