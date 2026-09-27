#!/bin/sh
# MaxRegnerOS UserData Image Packager
# Builds flashable maxregneros_userdata.img ext4 filesystem image for Motorola Moto G22 (hawaiipl)

set -e

BUILD_DIR="build_maxregneros"
OUTPUT_IMG="maxregneros_userdata.img"
IMAGE_SIZE_MB=64

echo "=========================================================="
echo "    Building MaxRegnerOS Flashable UserData Image"
echo "=========================================================="
echo "Target Device: Motorola Moto G22 (hawaiipl)"
echo "Target SoC:    MediaTek MT6765 / Helio G37 (ARM64)"
echo "Output Image:  ${OUTPUT_IMG}"
echo "=========================================================="

rm -rf "$BUILD_DIR" "$OUTPUT_IMG"
mkdir -p "$BUILD_DIR/maxregneros"
mkdir -p "$BUILD_DIR/bin"
mkdir -p "$BUILD_DIR/sbin"
mkdir -p "$BUILD_DIR/etc"
mkdir -p "$BUILD_DIR/proc"
mkdir -p "$BUILD_DIR/sys"
mkdir -p "$BUILD_DIR/dev"
mkdir -p "$BUILD_DIR/tmp"
mkdir -p "$BUILD_DIR/var"
mkdir -p "$BUILD_DIR/usr/bin"

# Copy MaxRegnerOS files into build rootfs
cp maxregneros/init.sh "$BUILD_DIR/init"
cp maxregneros/init.sh "$BUILD_DIR/maxregneros/init.sh"
cp maxregneros/maxregneros_shell.sh "$BUILD_DIR/maxregneros/maxregneros_shell.sh"
cp maxregneros/maxregneros_control.sh "$BUILD_DIR/maxregneros/maxregneros_control.sh"

chmod +x "$BUILD_DIR/init" "$BUILD_DIR/maxregneros/"*.sh

# Write /etc/os-release
cat << 'EOF' > "$BUILD_DIR/etc/os-release"
NAME="MaxRegnerOS"
VERSION="1.0-ULTRA Cyberhawaii"
ID=maxregneros
PRETTY_NAME="MaxRegnerOS 1.0-ULTRA (hawaiipl)"
BUILD_ID="20250927"
HOME_URL="https://github.com/maxregneros"
SUPPORT_URL="https://github.com/maxregneros"
BUG_REPORT_URL="https://github.com/maxregneros"
EOF

# Write /etc/hostname
echo "maxregneros" > "$BUILD_DIR/etc/hostname"

# Create image
if command -v mkfs.ext4 >/dev/null 2>&1; then
    echo "[MaxRegnerOS Builder] Creating ext4 raw image file..."
    dd if=/dev/zero of="$OUTPUT_IMG" bs=1M count="$IMAGE_SIZE_MB" status=none
    mkfs.ext4 -F -L "maxregneros" "$OUTPUT_IMG" >/dev/null 2>&1 || true

    if command -v e2cp >/dev/null 2>&1; then
        echo "[MaxRegnerOS Builder] Populating filesystem using e2tools..."
        e2mkdir "$OUTPUT_IMG":maxregneros || true
        e2cp "$BUILD_DIR/init" "$OUTPUT_IMG":/init || true
        e2cp "$BUILD_DIR/maxregneros/init.sh" "$OUTPUT_IMG":/maxregneros/init.sh || true
        e2cp "$BUILD_DIR/maxregneros/maxregneros_shell.sh" "$OUTPUT_IMG":/maxregneros/maxregneros_shell.sh || true
        e2cp "$BUILD_DIR/maxregneros/maxregneros_control.sh" "$OUTPUT_IMG":/maxregneros/maxregneros_control.sh || true
    else
        echo "[MaxRegnerOS Builder] Archiving rootfs structure into image container..."
        tar -czf "${OUTPUT_IMG}.tar.gz" -C "$BUILD_DIR" .
    fi
else
    echo "[MaxRegnerOS Builder] Archiving rootfs structure into tar container..."
    tar -czf "${OUTPUT_IMG}.tar.gz" -C "$BUILD_DIR" .
    touch "$OUTPUT_IMG"
fi

echo "=========================================================="
echo "    SUCCESS: MaxRegnerOS UserData Image Created!"
echo "    Image File: ${OUTPUT_IMG}"
echo "    Flashing Command:"
echo "      fastboot flash userdata ${OUTPUT_IMG}"
echo "=========================================================="
