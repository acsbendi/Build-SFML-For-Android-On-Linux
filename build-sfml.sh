#!/usr/bin/env bash

if [[ $# < 1 ]]; then
    echo "Please provide the path to your ndk"
    exit 1
fi

./check-requirements.sh
if [[ $? != 0 ]]; then
    exit 1
fi

ndk_input_path=$1
if [[ ${1: -1} != / ]]; then
    ndk_input_path=${ndk_input_path}/
fi

readonly CURRENT_PATH=$(dirname "$(readlink -f "$0")")

if [[ ${ndk_input_path:0:1} != / ]]; then
    readonly NDK_PATH=${CURRENT_PATH}/${ndk_input_path}
else
    readonly NDK_PATH=${ndk_input_path}
fi

if [[ $# < 2 ]]; then
    readonly INSTALL_PATH=~/SFML/
else
    readonly INSTALL_PATH=$2
fi

echo "Downloading SFML to ${INSTALL_PATH}"
mkdir -p ${INSTALL_PATH}
pushd ${INSTALL_PATH}
git clone https://github.com/acsbendi/SFML

cd SFML
mkdir build
cd build

# 64 bit abis (arm64-v8a and x86_64) currently fail due to not finding OpenAL, so they are not included
abis=(x86 armeabi-v7a)
for abi in ${abis[@]} ; do
    mkdir ${abi}
    echo "#!/usr/bin/env bash" > ${abi}/rebuild-temp
    echo "readonly CURRENT_ABI=${abi}" >> ${abi}/rebuild-temp
    echo "readonly NDK_PATH=${NDK_PATH}" >> ${abi}/rebuild-temp
done

popd
for abi in ${abis[@]} ; do
    temp_file_path=${INSTALL_PATH}/SFML/build/${abi}/rebuild-temp

    cat ${CURRENT_PATH}/rebuild.sh >> ${temp_file_path}
    cat ${temp_file_path} > ${INSTALL_PATH}/SFML/build/${abi}/rebuild.sh
    chmod +x ${INSTALL_PATH}/SFML/build/${abi}/rebuild.sh

    rm -rf ${temp_file_path}
done

cp ${CURRENT_PATH}/rebuild-all.sh ${INSTALL_PATH}/SFML/build/

${INSTALL_PATH}/SFML/build/rebuild-all.sh
