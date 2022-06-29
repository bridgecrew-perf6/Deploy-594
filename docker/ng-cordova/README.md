```
docker build --build-arg ANGULAR_VERSION=10.2.4 -t pmb69/cordova .
```

```
docker build --build-arg GITHUB_DIR=69pmb --build-arg GITHUB_PROJECT=AllMovies --build-arg GITHUB_HASH=master --build-arg ANGULAR_VERSION=10.2.4 --build-arg BUILD_DATE=2022-06-29T11:50:44Z -t allmovies.cordova https://raw.githubusercontent.com/69pmb/Deploy/feat/docker-cordova-build/docker/ng-cordova/Dockerfile
cordova prepare ?
```

```dockerfile
ARG GITHUB_DIR
ARG GITHUB_PROJECT
ARG GITHUB_HASH

RUN git clone -n https://github.com/${GITHUB_DIR}/${GITHUB_PROJECT}.git && \
    cd ${GITHUB_PROJECT} && \
    git checkout ${GITHUB_HASH} && \
    npm ci && \
    npm run cordova && \
	mv dist/ cordova/${GITHUB_PROJECT}/www/ && \
	cd cordova/${GITHUB_PROJECT} && \
	cordova build android

# /tmp/AllMovies/platforms/android/app/build/outputs/apk/debug/app-debug.apk
```
