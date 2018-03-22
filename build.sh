#!/bin/bash
export KBUILD_BUILD_USER=haoyangw
export KBUILD_BUILD_HOST=mystery
export ARCH=arm64
export CROSS_COMPILE=/Volumes/android/7.0/prebuilts/gcc/darwin-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android-

DIR=$(pwd)
BUILD="$DIR/build"
OUT="$DIR/out"
DATE=`date '+%Y-%m-%d_%H:%M'`
#NPR=`expr $(nproc) + 1`

echo "cleaning build..."
if [ -d "$BUILD" ]; then
rm -rf "$BUILD"
fi
if [ -d "$OUT" ]; then
rm -rf "$OUT"
fi

echo "setting up build..."
mkdir "$BUILD"
make O="$BUILD" lineageos_axon7_defconfig

echo "building kernel..."
make O="$BUILD" -j4 2>&1 | tee build_$DATE.txt

mkdir "$OUT"
mv "$BUILD/arch/arm64/boot/Image.gz-dtb" "$OUT/Image.gz-dtb"

echo "Image.gz-dtb can be found in $OUT"