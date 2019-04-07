#!/usr/bin/env bash

if [[ $# < 1 ]]; then
    echo "Please provide the path to your ndk"
    exit 1
fi

./check-requirements.sh
if [[ $? != 0 ]]; then
        exit 1
fi

readonly NDK_PATH=$1

if [[ $# < 2 ]]; then
    readonly INSTALL_PATH=~/SFML/
else
    readonly INSTALL_PATH=$2
fi

echo "Downloading SFML to ${INSTALL_PATH}"
mkdir -p ${INSTALL_PATH}
pushd ${INSTALL_PATH}
git clone https://github.com/SFML/SFML

cd SFML
mkdir build
cd build

abis=(x86 armeabi-v7a arm64-v8a x86_64)
for abi in ${abis[@]} ; do
    mkdir ${abi}
    echo "#!/usr/bin/env bash" > ${abi}/rebuild-temp
    echo "readonly CURRENT_ABI=${abi}" >> ${abi}/rebuild-temp
    echo "readonly NDK_PATH=${NDK_PATH}" >> ${abi}/rebuild-temp
done

popd
readonly TEMP_FILE_PATH=${INSTALL_PATH}/SFML/build/${abi}/rebuild-temp
readonly CURRENT_PATH=$(dirname "$(readlink -f "$0")")
for abi in ${abis[@]} ; do
    cat ${CURRENT_PATH}/rebuild.sh >> ${TEMP_FILE_PATH}
    cat ${TEMP_FILE_PATH} > ${INSTALL_PATH}/SFML/build/${abi}/rebuild.sh
    rm -rf ${TEMP_FILE_PATH}
done

cp ${CURRENT_PATH}/rebuild-all.sh ${INSTALL_PATH}/SFML/build/

${INSTALL_PATH}/SFML/build/rebuild-all.sh
