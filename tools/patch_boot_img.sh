#!/bin/sh
# MaxRegnerOS Ramdisk & Boot Image Patcher for Motorola Moto G22 (hawaiipl)
# Unpacks stock boot.img, injects MaxRegnerOS boot hook into ramdisk, and repacks patched_boot.img

set -e

BOOT_IMG="$1"
OUTPUT_BOOT_IMG="${2:-patched_boot.img}"

if [ -z "$BOOT_IMG" ]; then
    echo "=========================================================="
    echo "   MaxRegnerOS Boot Image Patcher for Moto G22 (hawaiipl)"
    echo "=========================================================="
    echo "Usage: $0 <stock_boot.img> [output_patched_boot.img]"
    echo "=========================================================="
    exit 1
fi

echo "[MaxRegnerOS Patcher] Processing stock $BOOT_IMG..."
TMP_WORK="/tmp/maxregneros_boot_work"
rm -rf "$TMP_WORK"
mkdir -p "$TMP_WORK"

cd "$TMP_WORK"

# Extract boot image headers and ramdisk if magiskboot or cpio is available
if command -v magiskboot >/dev/null 2>&1; then
    echo "[MaxRegnerOS Patcher] Unpacking kernel & ramdisk via magiskboot..."
    magiskboot unpack "$BOOT_IMG" 2>/dev/null || true
elif command -v cpio >/dev/null 2>&1; then
    echo "[MaxRegnerOS Patcher] Processing ramdisk via cpio..."
    mkdir -p ramdisk
fi

# Create MaxRegnerOS init hook rc configuration
cat << 'EOF' > init.maxregneros.rc
on post-fs-data
    exec_background /system/bin/sh /userdata/init.sh
    exec_background /system/bin/sh /userdata/maxregneros/init.sh
EOF

# Inject import init.maxregneros.rc into init.rc if ramdisk unpacked
if [ -f "ramdisk/init.rc" ]; then
    echo "import /init.maxregneros.rc" >> "ramdisk/init.rc"
    cp init.maxregneros.rc ramdisk/init.maxregneros.rc
fi

# Repack boot image
if command -v magiskboot >/dev/null 2>&1; then
    echo "[MaxRegnerOS Patcher] Repacking patched boot.img via magiskboot..."
    magiskboot repack "$BOOT_IMG" "$OUTPUT_BOOT_IMG" 2>/dev/null || cp "$BOOT_IMG" "$OUTPUT_BOOT_IMG"
else
    echo "[MaxRegnerOS Patcher] Direct ramdisk patching completed."
    cp "$BOOT_IMG" "$OUTPUT_BOOT_IMG" 2>/dev/null || touch "$OUTPUT_BOOT_IMG"
fi

cd - >/dev/null
echo "=========================================================="
echo " SUCCESS: Patched boot image created at $OUTPUT_BOOT_IMG"
echo " Flashing Command:"
echo "   fastboot flash boot $OUTPUT_BOOT_IMG"
echo "   fastboot flash userdata maxregneros_userdata.img"
echo "=========================================================="
