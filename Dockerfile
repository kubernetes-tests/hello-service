# GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o main
# microk8s.docker build . -t hello
# microk8s.kubectl expose deployment microbot --type=NodePort --port=80 --name=microbot-service
#CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o main .

FROM golang:alpine as builder
EXPOSE 3000
RUN adduser -D -H -u 10001 scratchuser
RUN ls /etc/ssl/certs | grep ca
COPY src .
RUN echo $PWD
RUN cd /go/main && \
    CGO_ENABLED=0 GOOS=linux  go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o main .
RUN cd /go/curlX && \
    CGO_ENABLED=0 GOOS=linux GOARCH=arm GOARM=7 go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o curlX .

FROM scratch
COPY --from=builder /etc/ssl/certs/ /etc/ssl/certs
COPY --from=builder /go/main/main /
COPY --from=builder /go/curlX/curlX /
COPY --from=builder /etc/passwd /etc/passwd
USER scratchuser
CMD ["./main"]