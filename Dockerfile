FROM        ubuntu:18.04
MAINTAINER  greshilov slavik greshilov@maps.me

# Never ask for confirmations
ENV DEBIAN_FRONTEND noninteractive

# Update apt-get
RUN rm -rf /var/lib/apt/lists/* && \
    apt-get update && \
    apt-get dist-upgrade -y


# Installing packages
RUN apt-get install -y \
    bash \
    openjdk-8-jdk \
    python \
    unzip \
    wget \
    --no-install-recommends

# Install Android SDK
RUN \
    wget --no-check-certificate \
    https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip && \
    mkdir /usr/local/android && \
    unzip sdk-tools-linux-3859397.zip -d /usr/local/android && \
    rm sdk-tools-linux-3859397.zip

# Configure SDK
RUN yes | /usr/local/android/tools/bin/sdkmanager "ndk-bundle" "platforms;android-23" "platforms;android-26" "build-tools;27.0.3" "cmake;3.6.4111459" "platform-tools"
RUN chmod -R 0777 /usr/local/android

ENV ANDROID_HOME /usr/local/android
ENV PATH $PATH:$ANDROID_HOME/ndk-bundle
