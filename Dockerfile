FROM nginx:alpine
RUN apk add --no-cache curl
COPY index.html /usr/share/nginx/html/index.html
RUN echo 'server { listen 3000; root /usr/share/nginx/html; index index.html; }' > /etc/nginx/conf.d/default.conf \
    && printf '#!/bin/sh\nwhile true; do echo "worker-tick $(date +%%H:%%M:%%S)"; sleep 5; done\n' > /worker.sh \
    && chmod +x /worker.sh
EXPOSE 3000
# slow-startup branch: sleep 30s before nginx accepts connections.
# The HEALTHCHECK below makes Docker Swarm wait for an actual HTTP
# 200 before marking the task healthy — without it, cobalt's wait
# returns the moment the container is "running", which fires before
# our sleep finishes and the patience path isn't actually exercised.
HEALTHCHECK --interval=2s --timeout=3s --start-period=40s --retries=3 \
    CMD curl -fsS http://localhost:3000/ || exit 1
CMD ["sh", "-c", "echo 'slow-startup: sleeping 30s before nginx'; sleep 30 && exec nginx -g 'daemon off;'"]
