FROM        centos:7
MAINTAINER  Ukhanov Anton a.ukhanov@corp.mail.ru

# Never ask for confirmations
ENV DEBIAN_FRONTEND noninteractive

# Installing packages
RUN yum install -y \
    curl \
    locales \
    which \
    openjdk-8-jdk \
    python36u-devel \
    java-1.8.0-openjdk \
    unzip \
    wget
RUN yum install -y https://centos7.iuscommunity.org/ius-release.rpm
RUN yum install -y \
    python36u python36u-pip \
    centos-release-scl-rh \
    devtoolset-6-libquadmath-devel \
    numpy \
    scipy

RUN export JAVA_HOME=/usr/bin/java

RUN yum-config-manager --add-repo http://pkg.corp.mail.ru/centos/6/mapsme/mapsme.repo
RUN yum install -y boost_prefix168*
# Install Android SDK
RUN \
    wget --no-check-certificate \
    https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip && \
    mkdir /usr/local/android && \
    unzip sdk-tools-linux-3859397.zip -d /usr/local/android && \
    rm sdk-tools-linux-3859397.zip

# Configure SDK
RUN /usr/local/android/tools/bin/sdkmanager "ndk-bundle" "platforms;android-23" "platforms;android-26" "build-tools;27.0.3" "cmake;3.6.4111459" "platform-tools"

RUN chmod -R 0777 /usr/local/android

# Install gradle
RUN wget --no-check-certificate \
    https://services.gradle.org/distributions/gradle-4.4-bin.zip && \
    unzip gradle-4.4-bin.zip -d /usr/local && \
    rm gradle-4.4-bin.zip && \
    chmod -R 0777 /usr/local/gradle-4.4


ENV ANDROID_HOME /usr/local/android
ENV PATH $PATH:$ANDROID_HOME/ndk-bundle:/usr/local/gradle-4.4/bin
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'