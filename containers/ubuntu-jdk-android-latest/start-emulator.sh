#!/bin/bash

emulator -avd "$AVD_NAME" -no-window -gpu swiftshader_indirect -noaudio -no-boot-anim -camera-back none &

# Wait for boot completion and press home button
adb wait-for-device

A=$(adb shell getprop sys.boot_completed | tr -d '\r')

while [ "$A" != "1" ]; do
    sleep 5
    A=$(adb shell getprop sys.boot_completed | tr -d '\r')
done

adb shell input keyevent 82

# Disable animations for faster tests
adb shell settings put global window_animation_scale 0.0
adb shell settings put global transition_animation_scale 0.0
adb shell settings put global animator_duration_scale 0.0

echo "Emulator '$AVD_NAME' booted!"
