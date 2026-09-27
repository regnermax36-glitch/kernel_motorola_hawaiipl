#!/bin/sh
# MaxRegnerOS Magisk Module Packager for Motorola Moto G22 (hawaiipl)
# Packages MaxRegnerOS Mobile Linux rootfs into flashable maxregneros_magisk_v1.0.zip

set -e

BUILD_DIR="build_magisk_module"
OUTPUT_ZIP="maxregneros_magisk_v1.0.zip"
ALPINE_TAR="/tmp/alpine-aarch64.tar.gz"
ALPINE_URL="https://dl-cdn.alpinelinux.org/alpine/v3.19/releases/aarch64/alpine-minirootfs-3.19.1-aarch64.tar.gz"

echo "=========================================================="
echo "  Building MaxRegnerOS Magisk Module Zip for Moto G22"
echo "=========================================================="

rm -rf "$BUILD_DIR" "$OUTPUT_ZIP"
mkdir -p "$BUILD_DIR/system/bin"
mkdir -p "$BUILD_DIR/ROOTFS"

# Step 1: Download & Extract Genuine Alpine ARM64 MiniRootFS
if [ ! -f "$ALPINE_TAR" ]; then
    echo "[MaxRegnerOS Magisk Builder] Downloading Alpine ARM64 rootfs..."
    curl -sL "$ALPINE_URL" -o "$ALPINE_TAR"
fi

echo "[MaxRegnerOS Magisk Builder] Unpacking rootfs..."
tar -xzf "$ALPINE_TAR" -C "$BUILD_DIR/ROOTFS"

# Step 2: Install MaxRegnerOS Core Components
mkdir -p "$BUILD_DIR/ROOTFS/maxregneros/bin"
mkdir -p "$BUILD_DIR/ROOTFS/maxregneros/src"
mkdir -p "$BUILD_DIR/ROOTFS/usr/bin"

cp maxregneros/init.sh "$BUILD_DIR/ROOTFS/init"
cp maxregneros/init.sh "$BUILD_DIR/ROOTFS/maxregneros/init.sh"
cp maxregneros/start.sh "$BUILD_DIR/ROOTFS/maxregneros/start.sh"
cp maxregneros/maxregneros_shell.sh "$BUILD_DIR/ROOTFS/maxregneros/maxregneros_shell.sh"
cp maxregneros/maxregneros_control.sh "$BUILD_DIR/ROOTFS/maxregneros/maxregneros_control.sh"
cp maxregneros/bin/maxpack "$BUILD_DIR/ROOTFS/maxregneros/bin/maxpack"
cp maxregneros/bin/maxgui "$BUILD_DIR/ROOTFS/maxregneros/bin/maxgui"
cp maxregneros/bin/maxprop.sh "$BUILD_DIR/ROOTFS/maxregneros/bin/maxprop.sh"
cp maxregneros/bin/maxsvc.sh "$BUILD_DIR/ROOTFS/maxregneros/bin/maxsvc.sh"
cp maxregneros/src/init.c "$BUILD_DIR/ROOTFS/maxregneros/src/init.c"

chmod +x "$BUILD_DIR/ROOTFS/init" "$BUILD_DIR/ROOTFS/maxregneros/"*.sh "$BUILD_DIR/ROOTFS/maxregneros/bin/"* 2>/dev/null || true

# Archive ROOTFS into tarball inside module directory
echo "[MaxRegnerOS Magisk Builder] Archiving rootfs into maxregneros_rootfs.tar.gz..."
tar -czf "$BUILD_DIR/maxregneros_rootfs.tar.gz" -C "$BUILD_DIR/ROOTFS" .
rm -rf "$BUILD_DIR/ROOTFS"

# Copy Magisk files
cp maxregneros/magisk/module.prop "$BUILD_DIR/module.prop"
cp maxregneros/magisk/service.sh "$BUILD_DIR/service.sh"
cp maxregneros/magisk/customize.sh "$BUILD_DIR/customize.sh"
cp maxregneros/magisk/system/bin/* "$BUILD_DIR/system/bin/"

chmod +x "$BUILD_DIR/service.sh" "$BUILD_DIR/customize.sh" "$BUILD_DIR/system/bin/"*

# Package Zip file
echo "[MaxRegnerOS Magisk Builder] Creating flashable zip $OUTPUT_ZIP..."
cd "$BUILD_DIR"
zip -r9 "../$OUTPUT_ZIP" . >/dev/null
cd - >/dev/null

echo "=========================================================="
echo " SUCCESS: Flashable Magisk Module Created!"
echo " Output File: $OUTPUT_ZIP"
echo " Install via: Magisk App -> Modules -> Install from storage"
echo "=========================================================="
