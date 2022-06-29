FROM timbru31/java-node:8-jdk-14

ENV DEBIAN_FRONTEND=noninteractive \
    TERM=xterm

# Android
# https://developer.android.com/studio/#downloads
ENV ANDROID_SDK_URL="https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip" \
    ANDROID_BUILD_TOOLS_VERSION=33.0.0 \
    ANT_HOME="/usr/share/ant" \
    MAVEN_HOME="/usr/share/maven" \
    GRADLE_HOME="/opt/gradle/gradle-6.5" \
    ANDROID_SDK_ROOT="/opt/android" \
    ANDROID_HOME="/opt/android"

ENV PATH $PATH:$ANDROID_SDK_ROOT/cmdline-tools/bin:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/build-tools/$ANDROID_BUILD_TOOLS_VERSION:$ANT_HOME/bin:$MAVEN_HOME/bin:$GRADLE_HOME/bin

WORKDIR /opt

RUN apt-get -qq update && \
    apt-get -qq install -y wget maven ant unzip --no-install-recommends

# Installs Android SDK
RUN mkdir android && cd android && \
    wget -q -O tools.zip ${ANDROID_SDK_URL} && \
    unzip -q tools.zip && rm tools.zip

# Gradle
RUN wget -q https://downloads.gradle-dn.com/distributions/gradle-6.5-all.zip && \
    mkdir /opt/gradle && \
    unzip -q -d /opt/gradle gradle-6.5-all.zip && \
    #    rm -rf gradle-6.5-all.zip && \
    ls /opt/gradle/gradle-6.5 && \
    chmod +775 /opt/gradle/gradle-6.5 && \
    gradle -v

RUN while true; do echo 'y'; sleep 2; done | sdkmanager --sdk_root=${ANDROID_SDK_ROOT} --include_obsolete --update && \
    while true; do echo 'y'; sleep 2; done | sdkmanager --sdk_root=${ANDROID_SDK_ROOT} --licenses && \
    mkdir /root/.android && touch /root/.android/repositories.cfg && \
    while true; do echo 'y'; sleep 2; done | sdkmanager --sdk_root=${ANDROID_SDK_ROOT} "emulator" "platform-tools" "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" && \
    while true; do echo 'y'; sleep 2; done | sdkmanager --sdk_root=${ANDROID_SDK_ROOT} "platforms;android-28" "platforms;android-29" "platforms;android-30" && \
    while true; do echo 'y'; sleep 2; done | sdkmanager --sdk_root=${ANDROID_SDK_ROOT} "platforms;android-31" "platforms;android-32" && \
    while true; do echo 'y'; sleep 2; done | sdkmanager --sdk_root=${ANDROID_SDK_ROOT} "extras;android;m2repository" "extras;google;google_play_services" "extras;google;instantapps" "extras;google;m2repository" && \
    while true; do echo 'y'; sleep 2; done | sdkmanager --sdk_root=${ANDROID_SDK_ROOT} "add-ons;addon-google_apis-google-22" "add-ons;addon-google_apis-google-23" "add-ons;addon-google_apis-google-24" "skiaparser;1" || true

RUN chmod a+x -R $ANDROID_SDK_ROOT && \
    chown -R root:root $ANDROID_SDK_ROOT && \
    mvn -v && java -version && ant -version

# Cordova
ENV CORDOVA_VERSION 10.0.0

WORKDIR "/tmp"

RUN npm i -g --unsafe-perm cordova@${CORDOVA_VERSION} && \
    cordova -v && \
    cd /tmp && \
    cordova create myApp com.myCompany.myApp myApp && \
    cd myApp && \
    cordova plugin add cordova-plugin-camera --save && \
    cordova platform add android --save

RUN cd /tmp/myApp && \
    export CORDOVA_ANDROID_GRADLE_DISTRIBUTION_URL=file:///opt/gradle-6.5-all.zip && \
    cordova build android --verbose && \
    rm -rf /tmp/myApp

# Angular
ARG ANGULAR_VERSION=12.2.13

RUN apt-get -qq update && \
    apt-get -qq install -y git openssh && \
    npm i -g @angular/cli@${ANGULAR_VERSION} && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get autoremove -y && \
    apt-get clean && \
    npm cache clean --force && \
    ng version
