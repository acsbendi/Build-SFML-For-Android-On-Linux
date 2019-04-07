#!/usr/bin/env bash

requirements=(wget unzip cmake git)

for requirement in ${requirements[@]} ; do
    if ! type "${requirement}" > /dev/null 2>&1; then
            echo "Requirement '${requirement}' not found!"
            exit 1
    fi
done