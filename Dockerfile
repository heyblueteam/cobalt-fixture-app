FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
RUN echo 'server { listen 3000; root /usr/share/nginx/html; index index.html; }' > /etc/nginx/conf.d/default.conf \
    && printf '#!/bin/sh\nwhile true; do echo "worker-tick $(date +%%H:%%M:%%S)"; sleep 5; done\n' > /worker.sh \
    && chmod +x /worker.sh
EXPOSE 3000
# slow-startup branch: sleep 30s before nginx accepts connections.
# Cobalt's deploy now probes the service's port from inside cobalt-caddy
# *after* swarm reports the task running, so this exercises that
# patience path without needing a Dockerfile HEALTHCHECK directive.
CMD ["sh", "-c", "echo 'slow-startup: sleeping 30s before nginx'; sleep 30 && exec nginx -g 'daemon off;'"]
