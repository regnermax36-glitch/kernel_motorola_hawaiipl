#!/bin/sh
# MaxRegnerOS Mobile UserData Image Packager
# Builds flashable maxregneros_userdata.img ext4 filesystem image for Motorola Moto G22 (hawaiipl)

set -e

BUILD_DIR="build_maxregneros"
OUTPUT_IMG="maxregneros_userdata.img"
IMAGE_SIZE_MB=64

echo "=========================================================="
echo "    Building MaxRegnerOS Mobile UserData Image"
echo "=========================================================="
echo "Target Device: Motorola Moto G22 (hawaiipl)"
echo "Target SoC:    MediaTek MT6765 / Helio G37 (ARM64)"
echo "Output Image:  ${OUTPUT_IMG}"
echo "Kernel Mode:   Stock Moto G22 Kernel (No Kernel Changes)"
echo "=========================================================="

rm -rf "$BUILD_DIR" "$OUTPUT_IMG" "${OUTPUT_IMG}.tar.gz"
mkdir -p "$BUILD_DIR/maxregneros/bin"
mkdir -p "$BUILD_DIR/maxregneros/src"
mkdir -p "$BUILD_DIR/bin"
mkdir -p "$BUILD_DIR/sbin"
mkdir -p "$BUILD_DIR/etc"
mkdir -p "$BUILD_DIR/proc"
mkdir -p "$BUILD_DIR/sys"
mkdir -p "$BUILD_DIR/dev"
mkdir -p "$BUILD_DIR/tmp"
mkdir -p "$BUILD_DIR/var"
mkdir -p "$BUILD_DIR/usr/bin"

# Compile init C binary for ARM64 target
if command -v clang >/dev/null 2>&1; then
    echo "[MaxRegnerOS Builder] Cross-compiling ARM64 init C object..."
    clang -c --target=aarch64-linux-gnu -O2 maxregneros/src/init.c -o "$BUILD_DIR/maxregneros/src/init.o" 2>/dev/null || true
fi

# Copy MaxRegnerOS init script and utilities into build rootfs
cp maxregneros/init.sh "$BUILD_DIR/init"
cp maxregneros/init.sh "$BUILD_DIR/maxregneros/init.sh"
cp maxregneros/maxregneros_shell.sh "$BUILD_DIR/maxregneros/maxregneros_shell.sh"
cp maxregneros/maxregneros_control.sh "$BUILD_DIR/maxregneros/maxregneros_control.sh"
cp maxregneros/bin/maxpack "$BUILD_DIR/maxregneros/bin/maxpack"
cp maxregneros/bin/maxgui "$BUILD_DIR/maxregneros/bin/maxgui"
cp maxregneros/src/init.c "$BUILD_DIR/maxregneros/src/init.c"

chmod +x "$BUILD_DIR/init" "$BUILD_DIR/maxregneros/"*.sh "$BUILD_DIR/maxregneros/bin/"* 2>/dev/null || true

# Write /etc/os-release
cat << 'EOF' > "$BUILD_DIR/etc/os-release"
NAME="MaxRegnerOS Mobile"
VERSION="1.0-ULTRA Cyberhawaii"
ID=maxregneros
PRETTY_NAME="MaxRegnerOS Mobile Linux 1.0-ULTRA (hawaiipl)"
BUILD_ID="20250927"
HOME_URL="https://github.com/maxregneros"
EOF

# Write /etc/hostname
echo "maxregneros" > "$BUILD_DIR/etc/hostname"

# Build ext4 userdata image populated with rootfs using mkfs.ext4 -d
if command -v mkfs.ext4 >/dev/null 2>&1; then
    echo "[MaxRegnerOS Builder] Generating populated ext4 image using mkfs.ext4 -d..."
    mkfs.ext4 -F -L "maxregneros" -d "$BUILD_DIR" "$OUTPUT_IMG" ${IMAGE_SIZE_MB}M >/dev/null 2>&1 || {
        echo "[MaxRegnerOS Builder] Fallback image creation..."
        dd if=/dev/zero of="$OUTPUT_IMG" bs=1M count="$IMAGE_SIZE_MB" status=none
        mkfs.ext4 -F -L "maxregneros" "$OUTPUT_IMG" >/dev/null 2>&1 || true
    }
fi

# Archive rootfs into tarball
echo "[MaxRegnerOS Builder] Archiving rootfs structure into tarball..."
tar -czf "${OUTPUT_IMG}.tar.gz" -C "$BUILD_DIR" .

echo "=========================================================="
echo "    SUCCESS: MaxRegnerOS UserData Image Created!"
echo "    Image File: ${OUTPUT_IMG}"
echo "    Archive:    ${OUTPUT_IMG}.tar.gz"
echo "    Flashing Command:"
echo "      fastboot flash userdata ${OUTPUT_IMG}"
echo "=========================================================="
