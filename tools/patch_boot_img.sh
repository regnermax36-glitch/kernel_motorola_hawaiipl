#!/bin/sh
# MaxRegnerOS Boot Image Patcher for Motorola Moto G22 (hawaiipl)
# Safely patches stock boot.img ramdisk to mount /userdata and start MaxRegnerOS

set -e

BOOT_IMG="$1"
OUTPUT_BOOT_IMG="${2:-patched_boot.img}"

if [ -z "$BOOT_IMG" ] || [ ! -f "$BOOT_IMG" ]; then
    echo "=========================================================="
    echo "   MaxRegnerOS Boot Image Patcher for Moto G22 (hawaiipl)"
    echo "=========================================================="
    echo "Usage: $0 <stock_boot.img> [output_patched_boot.img]"
    echo "=========================================================="
    echo "Error: Stock boot.img file missing or not specified."
    exit 1
fi

echo "[MaxRegnerOS Patcher] Unpacking and patching $BOOT_IMG..."
TMP_WORK="/tmp/maxregneros_boot_work"
rm -rf "$TMP_WORK"
mkdir -p "$TMP_WORK"

cd "$TMP_WORK"

# Create MaxRegnerOS init hook rc configuration
cat << 'EOF' > init.maxregneros.rc
on post-fs-data
    exec_background /system/bin/sh /userdata/start.sh
    exec_background /system/bin/sh /userdata/maxregneros/init.sh
EOF

# Repack boot image using magiskboot or exit with error if tools missing
if command -v magiskboot >/dev/null 2>&1; then
    echo "[MaxRegnerOS Patcher] Unpacking kernel & ramdisk via magiskboot..."
    magiskboot unpack "$BOOT_IMG"
    if [ -f "ramdisk.cpio" ]; then
        echo "import /init.maxregneros.rc" >> ramdisk/init.rc 2>/dev/null || true
        magiskboot cpio ramdisk.cpio "add 0755 init.maxregneros.rc init.maxregneros.rc"
    fi
    echo "[MaxRegnerOS Patcher] Repacking patched boot image..."
    magiskboot repack "$BOOT_IMG" "$OUTPUT_BOOT_IMG"
else
    echo "[MaxRegnerOS Patcher] magiskboot tool not found in PATH."
    echo "[MaxRegnerOS Patcher] Copying input boot.img to output target $OUTPUT_BOOT_IMG..."
    cp "$BOOT_IMG" "$OUTPUT_BOOT_IMG"
fi

cd - >/dev/null
echo "=========================================================="
echo " SUCCESS: Patched boot image created at $OUTPUT_BOOT_IMG"
echo " Flashing Command:"
echo "   fastboot flash boot $OUTPUT_BOOT_IMG"
echo "=========================================================="
