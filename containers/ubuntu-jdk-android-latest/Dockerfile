# ====================================================================== #
# Android SDK Docker Image
# ====================================================================== #

# Base image
# ---------------------------------------------------------------------- #
FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

# # support multiarch: i386 architecture
# # install Java
# # install essential tools
ARG JDK_VERSION=17
RUN dpkg --add-architecture i386 && \
    apt-get -qqy update && \
    apt-get dist-upgrade -y && \
    apt-get install -y --no-install-recommends \
    build-essential git wget unzip sudo \
    libncurses5:i386 libc6:i386 libstdc++6:i386 lib32gcc-s1 lib32ncurses6 lib32z1 zlib1g:i386 \
    qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils \
    openjdk-${JDK_VERSION}-jdk && \
    apt-get -yq autoremove && \
    apt-get clean && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV JAVA_HOME="/usr/lib/jvm/java-${JDK_VERSION}-openjdk-amd64" \
    PATH=$PATH:$JAVA_HOME/bin

#ARG USER=runner
# RUN groupadd -g 1000 -r $USER && \
#     useradd -u 1000 -g 1000 --create-home -r $USER && \
#     adduser $USER libvirt && \
#     adduser $USER kvm && \
#     echo "$USER:$USER" | chpasswd && \
#     echo "${USER} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-$USER && \
#     usermod -aG sudo $USER && \
#     usermod -aG plugdev $USER

# ARG USERNAME=androidrunner
# RUN groupadd ${USERNAME} \
#     --gid 1301 \
#     && useradd ${USERNAME} \
#     --uid 1300 \
#     --gid 1301 \
#     --create-home \
#     --shell /bin/bash \
#     && adduser ${USERNAME} libvirt \
#     && adduser ${USERNAME} kvm \
#     && usermod -aG sudo ${USERNAME} \
#     && usermod -aG plugdev ${USERNAME} \
#     && echo "${USERNAME}:${USERNAME}" | chpasswd \
#     && echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/90-${USERNAME}

# WORKDIR /home/${USERNAME}

# WORKDIR /

# ENV HOME /github/home
# WORKDIR ${HOME}

# ENV ANDROID_AVD_HOME=$HOME/.android/avd


# download and install Gradle
# https://services.gradle.org/distributions/
# ARG GRADLE_VERSION=8.3
# ARG GRADLE_DIST=bin
# RUN cd /opt && \
#     wget -q https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-${GRADLE_DIST}.zip && \
#     unzip gradle*.zip && \
#     ls -d */ | sed 's/\/*$//g' | xargs -I{} mv {} gradle && \
#     rm gradle*.zip

# # download and install Kotlin compiler
# # https://github.com/JetBrains/kotlin/releases/latest
# ARG KOTLIN_VERSION=1.9.10
# RUN cd /opt && \
#     wget -q https://github.com/JetBrains/kotlin/releases/download/v${KOTLIN_VERSION}/kotlin-compiler-${KOTLIN_VERSION}.zip && \
#     unzip *kotlin*.zip && \
#     rm *kotlin*.zip

# download and install Android SDK
# https://developer.android.com/studio#command-line-tools-only
# Set env variable for SDK Root (https://developer.android.com/studio/command-line/variables)
ARG ANDROID_SDK_VERSION=11076708
ENV ANDROID_HOME "/opt/android"
ENV ANDROID_SDK_ROOT "/opt/android"
ENV ANDROID_EMULATOR_HOME "/root/.android"
ENV ANDROID_AVD_HOME "/root/.android/avd"
RUN mkdir -p ${ANDROID_HOME}/cmdline-tools && \
    wget -q https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_VERSION}_latest.zip && \
    unzip *tools*linux*.zip -d ${ANDROID_HOME}/cmdline-tools && \
    mv ${ANDROID_HOME}/cmdline-tools/cmdline-tools ${ANDROID_HOME}/cmdline-tools/tools && \
    rm *tools*linux*.zip

# chmod a+x -R ${ANDROID_HOME}/cmdline-tools && \
# chown -R 1300:1301 ${ANDROID_HOME}/cmdline-tools && \

ENV PATH=${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/cmdline-tools/tools/bin:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/emulator:${ANDROID_HOME}/build-tools

ARG BUILD_TOOLS_VERSION="34.0.0"
ARG PLATFORM_VERSION="34"
ARG IMG_API_LEVEL=29
ARG TEST_IMG_PCKG="system-images;android-${IMG_API_LEVEL};google_apis;x86"
RUN mkdir -p ~/.android && \
    touch ~/.android/repositories.cfg && \
    echo y | sdkmanager --licenses && \
    echo y | sdkmanager --install "build-tools;${BUILD_TOOLS_VERSION}" \
    "platform-tools" "emulator" "platforms;android-${PLATFORM_VERSION}" \
    ${TEST_IMG_PCKG} && \
    mv ~/.android .android
# chown -R 1300:1301 .android

# set the environment variables
#ENV JAVA_HOME /usr/lib/jvm/java-${JDK_VERSION}-openjdk-amd64
# ENV GRADLE_HOME /opt/gradle
# ENV KOTLIN_HOME /opt/kotlinc
# ENV PATH=${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/cmdline-tools/tools/bin:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/emulator:${ANDROID_HOME}/build-tools
# WORKAROUND: for issue https://issuetracker.google.com/issues/37137213
ENV LD_LIBRARY_PATH ${ANDROID_HOME}/emulator/lib64:${ANDROID_HOME}/emulator/lib64/qt/lib
# patch emulator issue: Running as root without --no-sandbox is not supported. See https://crbug.com/638180.
# https://doc.qt.io/qt-5/qtwebengine-platform-notes.html#sandboxing-support
ENV QTWEBENGINE_DISABLE_SANDBOX 1

# RUN yes | sdkmanager --licenses

# ARG BUILD_TOOLS_VERSION="34.0.0"
# RUN yes | sdkmanager --install "build-tools;${BUILD_TOOLS_VERSION}" "platform-tools" "emulator"

# ARG IMG_API_LEVEL=29
# ARG TEST_IMG_PCKG="system-images;android-${IMG_API_LEVEL};google_apis;x86"
# RUN yes | sdkmanager --install ${TEST_IMG_PCKG}

# ARG AVD_NAME="test"
# RUN echo no | avdmanager create avd --force -n "${AVD_NAME}" --abi 'google_apis/x86' --package ${TEST_IMG_PCKG}

# COPY containers/ubuntu-jdk-android-latest/start-emulator.sh /usr/bin
# RUN chmod +x /usr/bin/start-emulator.sh

ENV SCRIPT_PATH="dce-scripts"
RUN mkdir -p ${SCRIPT_PATH}

COPY start.sh ${SCRIPT_PATH}
# RUN chown -R 1300:1301 ${SCRIPT_PATH} && \
#     chmod +x ${SCRIPT_PATH}/start.sh

RUN chmod +x ${SCRIPT_PATH}/start.sh

USER root

# Expose adb
EXPOSE 5037 5554 5555 5900

CMD ./${SCRIPT_PATH}/start.sh