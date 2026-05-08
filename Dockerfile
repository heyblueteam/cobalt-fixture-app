FROM alpine:3.20
RUN apk add --no-cache busybox-extras
WORKDIR /app
COPY index.html /app/index.html
EXPOSE 3000
CMD ["sh", "-c", "echo \"$(date) cobalt-fixture-app starting\"; while true; do { printf 'HTTP/1.1 200 OK\\r\\nContent-Type: text/html\\r\\nConnection: close\\r\\n\\r\\n'; cat /app/index.html; } | nc -l -p 3000 -q 1; done"]
