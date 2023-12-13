#!/usr/bin/env bash

readonly CURRENT_PATH=$(dirname "$(readlink -f "$0")")

abis=(x86 armeabi-v7a arm64-v8a x86_64)
for abi in ${abis[@]} ; do
    pushd ${CURRENT_PATH}/${abi}
    if type gnome-terminal > /dev/null 2>&1; then
        gnome-terminal --tab -e "/bin/bash -c '${CURRENT_PATH}/${abi}/rebuild.sh; exec /bin/bash -i'" # The terminal should not be closed after the script finished running.
    else
        ${CURRENT_PATH}/${abi}/rebuild.sh
    fi
    popd
done
