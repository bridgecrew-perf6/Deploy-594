FROM tobi312/rpi-nginx:alpine

LABEL MAINTAINER PMB <pmbroca@gmail.com>

COPY conf /etc/nginx/

HEALTHCHECK --interval=120s CMD wget --spider -q http://localhost:8080
