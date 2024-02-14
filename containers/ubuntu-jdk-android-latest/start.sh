#!/bin/bash

# It is workaround to access adb from the created user
echo "Prepare adb to have access to device"
sudo /opt/android/platform-tools/adb devices >/dev/null
sudo chown -R 1300:1301 .android
echo "adb can be used now"