FROM nginxinc/nginx-unprivileged:1.29.0-alpine
COPY nginx.conf /etc/nginx/nginx.conf
