FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
RUN echo 'server { listen 3000; root /usr/share/nginx/html; index index.html; }' > /etc/nginx/conf.d/default.conf
EXPOSE 3000
