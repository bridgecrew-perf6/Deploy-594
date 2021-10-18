### What is Ng-Nginx ?
The goal of this image is to serve a static site developed with Angular, NodeJS or plain JS on a Raspberry Pi.  
It is based on the [rpi-nginx's tobi312](https://github.com/Tob1asDocker/rpi-nginx) image.

### How to use it ?

Once your application is built, you can run a docker container using:  
```bash
docker run --name my-app -d -p my-port:8080 -v absolute-path-built-app:/usr/share/nginx/html -t pmb69/ng-nginx:0.1.0
```
If not running on a Raspberry, you can add for instance `--platform linux/arm/v7` to run it.
