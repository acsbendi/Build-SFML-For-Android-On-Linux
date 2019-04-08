#!/usr/bin/env bash

readonly CURRENT_PATH=$(dirname "$(readlink -f "$0")")

# 64 bit abis (arm64-v8a and x86_64) currently fail due to not finding OpenAL, so they are not included
abis=(x86 armeabi-v7a)
for abi in ${abis[@]} ; do
    pushd ${CURRENT_PATH}/${abi}
    gnome-terminal --tab -e "/bin/bash -c '${CURRENT_PATH}/${abi}/rebuild.sh; exec /bin/bash -i'" # The terminal should not be closed after the script finished running.
    popd
done
