# Build SFML For Android On Linux
Bash scripts to build SFML for Android, using the latest Android NDK

# Requirements

Successfully building SFML requires that you have 
* `cmake` (minimum version is **3.7.2**)
* `make`
* `git`
* `unzip`
* `wget`

Additional requirements to enable parallel builds (compile SFML for every ABI at the same time):

* `gnome-terminal`

# How to use it

### ● If you have NDK installed:

Run `build-sfml.sh` followed by the absolute path to your NDK. For example, if your NDK is located at /home/test/android-ndk-r19, then you have to run `./build-sfml.sh /home/test/android-ndk-r19`.
        
### ● If you don't have NDK installed:

You can install the newest version before building SFML, by executing `download-ndk-and-build-sfml.sh`. You can also specify where to install ndk, by providing an absolute path to the script. For example, if you want to install it in /etc/Android, then you should run `download-ndk-and-build-sfml.sh /etc/Android`. After downloading the NDK, this script will also run `build-sfml.sh` and thus build SFML.

## Path to the downloaded SFML repository

The script will download SFML to ~/SFML. For example, if your username is foo, you will be able to find the downloaded SFML repository at /home/foo/SFML.

## Created scripts

The following scripts are created in ~/SFML/build and its subdirectories. They are also run by `build-sfml.sh` when it builds SFML for the first time. You can use them to rebuild SFML in case you modify something in it.

#### ● `rebuild-all.sh`: 
Rebuilds SFML for all ABIs.

#### ● `rebuild.sh` (in each ABI's directory): 
Rebuilds SFML for the ABI corrisponding to script's directory.

## 64-bit ABIs
The 64-bit ABIs (`x86_64` and `arm64-v8a`) require several libraries before they can be compiled. They are skipped by default unless you set the `COMPILE_64_BIT_ABIS` environment variable. You will also have to provide paths to the required libraries for either ABI.

#### ● `x86_64`:
```bash
export X86_64_OPENAL=/path/to/libopenal.so
export X86_64_FLAC=/path/to/libFLAC.so
export X86_64_FREETYPE=/path/to/libfreetype.so
export X86_64_VORBIS=/path/to/libvorbis.so
export X86_64_VORBISENC=/path/to/libvorbisenc.so
export X86_64_VORBISFILE=/path/to/libvorbisfile.so
export X86_64_OGG=/path/to/libogg.so
```

#### ● `arm64-v8a`:
```bash
export ARM64_V8A_OPENAL=/path/to/libopenal.so
export ARM64_V8A_FLAC=/path/to/libFLAC.so
export ARM64_V8A_FREETYPE=/path/to/libfreetype.so
export ARM64_V8A_VORBIS=/path/to/libvorbis.so
export ARM64_V8A_VORBISENC=/path/to/libvorbisenc.so
export ARM64_V8A_VORBISFILE=/path/to/libvorbisfile.so
export ARM64_V8A_OGG=/path/to/libogg.so
```
