#@IgnoreInspection BashAddShebang

patterns_to_remove=(src CMakeFiles lib SFML* CMake* Makefile install* cmake*)

for ptr in ${patterns_to_remove[@]} ; do
    rm -rf ${ptr}
done

EXTRA_CACHE_FLAGS=""

if [ ${CURRENT_ABI} = "x86_64" ]
then

    if [ "${COMPILE_64_BIT_ABIS}" = "" ]
    then

        echo "COMPILE_64_BIT_ABIS is unset; Skipped x86_64"
        return 0

    fi

    EXTRA_CACHE_FLAGS="-DOPENAL_LIBRARY=${X86_64_OPENAL} -DFLAC_LIBRARY=${X86_64_FLAC} -DFREETYPE_LIBRARY=${X86_64_FREETYPE} -DVORBIS_LIBRARY=${X86_64_VORBIS} -DVORBISENC_LIBRARY=${X86_64_VORBISENC} -DVORBISFILE_LIBRARY=${X86_64_VORBISFILE} -DOGG_LIBRARY=${X86_64_OGG}"

fi

if [ ${CURRENT_ABI} = "arm64-v8a" ]
then

    if [ "${COMPILE_64_BIT_ABIS}" = "" ]
    then

        echo "COMPILE_64_BIT_ABIS is unset; Skipped arm64-v8a"
        return 0

    fi

    EXTRA_CACHE_FLAGS="-DOPENAL_LIBRARY=${ARM64_V8A_OPENAL} -DFLAC_LIBRARY=${ARM64_V8A_FLAC} -DFREETYPE_LIBRARY=${ARM64_V8A_FREETYPE} -DVORBIS_LIBRARY=${ARM64_V8A_VORBIS} -DVORBISENC_LIBRARY=${ARM64_V8A_VORBISENC} -DVORBISFILE_LIBRARY=${ARM64_V8A_VORBISFILE} -DOGG_LIBRARY=${ARM64_V8A_OGG}"

fi

cmake -DANDROID_ABI=${CURRENT_ABI} -DANDROID_PLATFORM=android-21 -stdlib=libc++ -DCMAKE_TOOLCHAIN_FILE=${NDK_PATH}build/cmake/android.toolchain.cmake -DCMAKE_ANDROID_NDK_TOOLCHAIN_VERSION=clang -DCMAKE_SYSTEM_NAME=Android -DCMAKE_ANDROID_NDK=${NDK_PATH} -DCMAKE_ANDROID_STL_TYPE=c++_static -DCMAKE_BUILD_TYPE=Debug ${EXTRA_CACHE_FLAGS} -G "Unix Makefiles" ../..
make
make install
