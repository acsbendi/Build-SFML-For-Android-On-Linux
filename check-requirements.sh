#!/usr/bin/env bash

requirements=(wget unzip cmake git make)

for requirement in ${requirements[@]} ; do
    if ! type "${requirement}" > /dev/null 2>&1; then
            echo "Requirement '${requirement}' not found!"
            exit 1
    fi
done

bad_cmake_version(){
    echo "Minimum required CMake version is ${REQUIRED_CMAKE_MAJOR}.${REQUIRED_CMAKE_MINOR}.${REQUIRED_CMAKE_PATCH}"
    echo "You only have ${CMAKE_VERSION}"
    echo "Please upgrade your CMake"
    exit 1
}

readonly REQUIRED_CMAKE_MAJOR=3
readonly REQUIRED_CMAKE_MINOR=7
readonly REQUIRED_CMAKE_PATCH=2

readonly CMAKE_VERSION=$(cmake --version | head -n 1 | sed 's/cmake version //g')
readonly CMAKE_MAJOR=$(echo ${CMAKE_VERSION} | sed -r 's/^([0-9]+).*$/\1/')
readonly CMAKE_MINOR=$(echo ${CMAKE_VERSION} | sed -r 's/^[0-9]+\.([0-9]+).*$/\1/')
readonly CMAKE_PATCH=$(echo ${CMAKE_VERSION} | sed -r 's/^[0-9]+\.[0-9]+\.([0-9]+).*$/\1/')

if [[ ${CMAKE_MAJOR} < ${REQUIRED_CMAKE_MAJOR} ]] ; then
    bad_cmake_version
elif [[ ${CMAKE_MAJOR} > ${REQUIRED_CMAKE_MAJOR} ]] ; then
    exit 0
fi

if [[ ${CMAKE_MINOR} < ${REQUIRED_CMAKE_MINOR} ]] ; then
    bad_cmake_version
elif [[ ${CMAKE_MINOR} > ${REQUIRED_CMAKE_MINOR} ]] ; then
    exit 0
fi

if [[ ${CMAKE_PATCH} < ${REQUIRED_CMAKE_PATCH} ]] ; then
    bad_cmake_version
else
    exit 0
fi