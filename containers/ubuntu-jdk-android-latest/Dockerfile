# Base image
# ---------------------------------------------------------------------- #
FROM ubuntu:latest

# Set noninteractive mode
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
ARG JDK_VERSION=17
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential git wget unzip sudo \
    qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils \
    openjdk-${JDK_VERSION}-jdk \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV JAVA_HOME="/usr/lib/jvm/java-${JDK_VERSION}-openjdk-amd64" \
    ANDROID_HOME="/opt/android" \
    ANDROID_SDK_ROOT="/opt/android" \
    ANDROID_EMULATOR_HOME="/root/.android" \
    ANDROID_AVD_HOME="/root/.android/avd" \
    LD_LIBRARY_PATH="${ANDROID_HOME}/emulator/lib64:${ANDROID_HOME}/emulator/lib64/qt/lib" \
    QTWEBENGINE_DISABLE_SANDBOX=1

# download and install Android SDK
ARG ANDROID_SDK_VERSION=11076708
RUN mkdir -p ${ANDROID_HOME}/cmdline-tools && \
    wget -qO sdk.zip "https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_VERSION}_latest.zip" && \
    unzip -qq sdk.zip -d ${ANDROID_HOME}/cmdline-tools && \
    mv ${ANDROID_HOME}/cmdline-tools/cmdline-tools ${ANDROID_HOME}/cmdline-tools/tools && \
    rm sdk.zip

# Add Android SDK binaries to the PATH
ENV PATH="${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/cmdline-tools/tools/bin:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/emulator:${ANDROID_HOME}/build-tools"

# Install required Android SDK components
ARG BUILD_TOOLS_VERSION="34.0.0"
ARG PLATFORM_VERSION="34"
ARG IMG_API_LEVEL=29
ARG TEST_IMG_PCKG="system-images;android-${IMG_API_LEVEL};google_apis;x86"
RUN mkdir -p ~/.android && \
    touch ~/.android/repositories.cfg && \
    yes | sdkmanager --licenses && \
    yes | sdkmanager --install "build-tools;${BUILD_TOOLS_VERSION}" \
    "platform-tools" "emulator" "platforms;android-${PLATFORM_VERSION}" \
    ${TEST_IMG_PCKG} && \
    mv ~/.android .android

# not recommended (just for testing in github workflow) 
USER root

# Expose adb ports
EXPOSE 5037 5554 5555 5900