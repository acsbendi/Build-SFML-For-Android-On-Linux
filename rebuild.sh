#@IgnoreInspection BashAddShebang

patterns_to_remove=(src CMakeFiles lib SFML* CMake* Makefile install* cmake*)

for ptr in ${patterns_to_remove[@]} ; do
    rm -rf ${ptr}
done

cmake -DANDROID_ABI=${CURRENT_ABI} -DANDROID_PLATFORM=android-21 -stdlib=libc++ -DCMAKE_TOOLCHAIN_FILE=${NDK_PATH}/build/cmake/android.toolchain.cmake -DCMAKE_ANDROID_NDK_TOOLCHAIN_VERSION=clang -DCMAKE_SYSTEM_NAME=Android -DCMAKE_ANDROID_NDK=${NDK_PATH} -DCMAKE_ANDROID_STL_TYPE=c++_static -DCMAKE_BUILD_TYPE=Debug -G "MinGW Makefiles" ../..
make
make install