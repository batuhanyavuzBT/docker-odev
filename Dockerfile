cat <<'EOF' > Dockerfile
FROM ubuntu

RUN apt update && apt install -y nginx gettext-base

COPY index.html /var/www/html/index.html

RUN rm -f /etc/nginx/sites-enabled/default
RUN printf 'server {\n  listen ${PORT};\n  location / { root /var/www/html; index index.html; }\n}\n' > /etc/nginx/conf.d/render.template

CMD ["/bin/bash","-lc","envsubst '$PORT' < /etc/nginx/conf.d/render.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"]
EOF
