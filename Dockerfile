FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
RUN echo 'server { listen 3000; root /usr/share/nginx/html; index index.html; }' > /etc/nginx/conf.d/default.conf \
    && printf '#!/bin/sh\nwhile true; do echo "worker-tick $(date +%%H:%%M:%%S)"; sleep 5; done\n' > /worker.sh \
    && chmod +x /worker.sh
EXPOSE 3000
# crash-loop branch: web container exits 1 on start. The deploy
# must fail; the previously-running container should remain the
# one Caddy points at (no traffic blackhole).
CMD ["sh", "-c", "echo 'crash-loop branch: exiting 1'; exit 1"]
