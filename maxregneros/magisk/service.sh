#!/system/bin/sh
# MaxRegnerOS Systemless Late-Start Service
# Executed automatically by Magisk boot sequence on Stock Android 12

MODDIR=${0%/*}
MAXROOT="/data/adb/maxregneros"

# Wait for boot completion
until [ "$(getprop sys.boot_completed)" = "1" ]; do
    sleep 2
done

# Initialize MaxRegnerOS chroot/rootfs environment
mkdir -p "$MAXROOT/proc" "$MAXROOT/sys" "$MAXROOT/dev" "$MAXROOT/dev/pts" "$MAXROOT/tmp" "$MAXROOT/system" "$MAXROOT/vendor" "$MAXROOT/data"

mount -t proc proc "$MAXROOT/proc" 2>/dev/null || true
mount -t sysfs sysfs "$MAXROOT/sys" 2>/dev/null || true
mount -o bind /dev "$MAXROOT/dev" 2>/dev/null || true
mount -o bind /dev/pts "$MAXROOT/dev/pts" 2>/dev/null || true
mount -o bind /system "$MAXROOT/system" 2>/dev/null || true
mount -o bind /vendor "$MAXROOT/vendor" 2>/dev/null || true
mount -o bind /data "$MAXROOT/data" 2>/dev/null || true

# Initialize MT6765 Governor & CyberBoost Daemon
if [ -f "$MAXROOT/maxregneros/maxregneros_control.sh" ]; then
    chroot "$MAXROOT" /bin/sh /maxregneros/maxregneros_control.sh init 2>/dev/null || true
fi

echo "[MaxRegnerOS Service] Systemless boot service active."
