# Dockerfile Environment Configuration

>[!important]
>
> This Docker image is designed for autograding Android projects submitted by students via GitHub Classroom. It simplifies the setup and execution of the autograding process

This Dockerfile sets up an environment for Android development, including the installation of JDK and Android SDK components. Below is a summary of what is installed and the environment variables set.

## Installed Packages

| Package                     | Version |
|-----------------------------|---------|
| build-essential             | -       |
| git                         | -       |
| wget                        | -       |
| unzip                       | -       |
| sudo                        | -       |
| qemu-kvm                    | -       |
| libvirt-daemon-system       | -       |
| libvirt-clients             | -       |
| bridge-utils                | -       |
| openjdk-${JDK_VERSION}-jdk  | 17      |
| Android SDK                 | -       |
| Android Build Tools         | 34.0.0 |
| Android Platform Tools      | 11076708 |
| Android Emulator            | -       |
| Android Platform            | 34 |
| Google APIs System Image    | 29 |

## Environment Variables

| Variable               | Value                                   |
|------------------------|-----------------------------------------|
| JAVA_HOME              | /usr/lib/jvm/java-17-openjdk-amd64 |
| ANDROID_HOME           | /opt/android                            |
| ANDROID_SDK_ROOT       | /opt/android                            |
| ANDROID_EMULATOR_HOME  | /root/.android                          |
| ANDROID_AVD_HOME       | /root/.android/avd                      |
| LD_LIBRARY_PATH        | ${ANDROID_HOME}/emulator/lib64:${ANDROID_HOME}/emulator/lib64/qt/lib |
| QTWEBENGINE_DISABLE_SANDBOX | 1                                     |
| PATH                   | ${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/cmdline-tools/tools/bin:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/emulator:${ANDROID_HOME}/build-tools |

## Build and run

**Build the image**:

```bash
docker build -t ubnutu-jdk17-android34 containers/ubuntu-jdk-android-latest/
```

**Run the container**:

```bash
docker run --privileged -it --device /dev/kvm ubnutu-jdk17-android34 bash
```
