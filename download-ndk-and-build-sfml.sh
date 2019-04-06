#!/usr/bin/env bash

./check_requirements.sh
if [[ $? != 0 ]]; then
        exit 1
fi

readonly LATEST_NDK_VERSION=19c
readonly ANDROID_ZIP_NAME=android-ndk-r${LATEST_NDK_VERSION}-linux-x86_64.zip

if [[ $# > 0 ]]; then
    readonly NDK_DOWNLOAD_PATH=%1
else
    readonly CURRENT_PATH=$(dirname "$(readlink -f "$0")")
    readonly NDK_DOWNLOAD_PATH=${CURRENT_PATH}
fi

wget --directory-prefix ${NDK_DOWNLOAD_PATH} https://dl.google.com/android/repository/${ANDROID_ZIP_NAME}

unzip ${NDK_DOWNLOAD_PATH}/${ANDROID_ZIP_NAME} -d ${NDK_DOWNLOAD_PATH}

./build-sfml.bat ${NDK_DOWNLOAD_PATH}/android-ndk-r${LATEST_NDK_VERSION}