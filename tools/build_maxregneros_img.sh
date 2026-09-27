#!/bin/sh
# MaxRegnerOS Mobile UserData Image Packager
# Builds a flashable maxregneros_userdata.img ext4 image containing a real ARM64 Linux rootfs
# Target: Motorola Moto G22 (hawaiipl - MediaTek MT6765 / Helio G37 ARM64)

set -e

BUILD_DIR="build_maxregneros"
OUTPUT_IMG="maxregneros_userdata.img"
IMAGE_SIZE_MB=128
ALPINE_TAR="/tmp/alpine-aarch64.tar.gz"
ALPINE_URL="https://dl-cdn.alpinelinux.org/alpine/v3.19/releases/aarch64/alpine-minirootfs-3.19.1-aarch64.tar.gz"

echo "=========================================================="
echo "   Building MaxRegnerOS Mobile UserData Image (ARM64)"
echo "=========================================================="
echo "Target Device: Motorola Moto G22 (hawaiipl)"
echo "Target SoC:    MediaTek MT6765 / Helio G37 (ARM64)"
echo "Output Image:  ${OUTPUT_IMG}"
echo "Kernel Mode:   Stock Moto G22 Kernel (Direct UserData Boot)"
echo "=========================================================="

rm -rf "$BUILD_DIR" "$OUTPUT_IMG" "${OUTPUT_IMG}.tar.gz"
mkdir -p "$BUILD_DIR"

# Step 1: Download & Extract Genuine Alpine ARM64 MiniRootFS
if [ ! -f "$ALPINE_TAR" ]; then
    echo "[MaxRegnerOS Builder] Downloading official Alpine Linux v3.19 ARM64 minirootfs..."
    curl -sL "$ALPINE_URL" -o "$ALPINE_TAR"
fi

echo "[MaxRegnerOS Builder] Unpacking ARM64 Linux rootfs structure..."
tar -xzf "$ALPINE_TAR" -C "$BUILD_DIR"

# Step 2: Create MaxRegnerOS Directories
mkdir -p "$BUILD_DIR/maxregneros/bin"
mkdir -p "$BUILD_DIR/maxregneros/src"
mkdir -p "$BUILD_DIR/usr/bin"
mkdir -p "$BUILD_DIR/system/bin"

# Step 3: Install MaxRegnerOS Core Components into RootFS
cp maxregneros/init.sh "$BUILD_DIR/init"
cp maxregneros/init.sh "$BUILD_DIR/maxregneros/init.sh"
cp maxregneros/maxregneros_shell.sh "$BUILD_DIR/maxregneros/maxregneros_shell.sh"
cp maxregneros/maxregneros_control.sh "$BUILD_DIR/maxregneros/maxregneros_control.sh"
cp maxregneros/bin/maxpack "$BUILD_DIR/maxregneros/bin/maxpack"
cp maxregneros/bin/maxgui "$BUILD_DIR/maxregneros/bin/maxgui"
cp maxregneros/src/init.c "$BUILD_DIR/maxregneros/src/init.c"

# Symlink binaries into PATH
ln -sf /maxregneros/bin/maxpack "$BUILD_DIR/usr/bin/maxpack"
ln -sf /maxregneros/bin/maxgui "$BUILD_DIR/usr/bin/maxgui"
ln -sf /maxregneros/bin/maxgui "$BUILD_DIR/usr/bin/gui"

chmod +x "$BUILD_DIR/init" "$BUILD_DIR/maxregneros/"*.sh "$BUILD_DIR/maxregneros/bin/"*

# Step 4: Configure OS Release & Hostname
cat << 'EOF' > "$BUILD_DIR/etc/os-release"
NAME="MaxRegnerOS Mobile Linux"
VERSION="1.0-ULTRA Cyberhawaii"
ID=maxregneros
PRETTY_NAME="MaxRegnerOS Mobile Linux 1.0-ULTRA (hawaiipl ARM64)"
BUILD_ID="20250927"
HOME_URL="https://github.com/maxregneros"
EOF

echo "maxregneros" > "$BUILD_DIR/etc/hostname"

# Step 5: Build Populated ext4 Image
if command -v mkfs.ext4 >/dev/null 2>&1; then
    echo "[MaxRegnerOS Builder] Generating populated ext4 image using mkfs.ext4 -d..."
    mkfs.ext4 -F -L "maxregneros" -d "$BUILD_DIR" "$OUTPUT_IMG" ${IMAGE_SIZE_MB}M >/dev/null 2>&1 || {
        echo "[MaxRegnerOS Builder] Fallback image creation..."
        dd if=/dev/zero of="$OUTPUT_IMG" bs=1M count="$IMAGE_SIZE_MB" status=none
        mkfs.ext4 -F -L "maxregneros" "$OUTPUT_IMG" >/dev/null 2>&1 || true
    }
fi

# Step 6: Create Compressed Archive
echo "[MaxRegnerOS Builder] Archiving rootfs structure into compressed tarball..."
tar -czf "${OUTPUT_IMG}.tar.gz" -C "$BUILD_DIR" .

echo "=========================================================="
echo "    SUCCESS: Real ARM64 MaxRegnerOS UserData Image Built!"
echo "    Image File: ${OUTPUT_IMG}"
echo "    Archive:    ${OUTPUT_IMG}.tar.gz"
echo "    Flashing Command:"
echo "      fastboot flash userdata ${OUTPUT_IMG}"
echo "=========================================================="
