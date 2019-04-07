#!/usr/bin/env bash

./check-requirements.sh
if [[ $? != 0 ]]; then
        exit 1
fi

readonly LATEST_NDK_VERSION=19c
readonly ANDROID_ZIP_NAME=android-ndk-r${LATEST_NDK_VERSION}-linux-x86_64.zip

if [[ $# > 0 ]]; then
    readonly NDK_DOWNLOAD_PATH=$1
else
    readonly CURRENT_PATH=$(dirname "$(readlink -f "$0")")
    readonly NDK_DOWNLOAD_PATH=${CURRENT_PATH}
fi

echo "Downloading Android NDK..."
wget --no-verbose --directory-prefix ${NDK_DOWNLOAD_PATH} https://dl.google.com/android/repository/${ANDROID_ZIP_NAME}
echo "Unzipping Android NDK..."
unzip -q -d ${NDK_DOWNLOAD_PATH} ${NDK_DOWNLOAD_PATH}/${ANDROID_ZIP_NAME}
rm -rf ${NDK_DOWNLOAD_PATH}/${ANDROID_ZIP_NAME}

./build-sfml.sh ${NDK_DOWNLOAD_PATH}/android-ndk-r${LATEST_NDK_VERSION}