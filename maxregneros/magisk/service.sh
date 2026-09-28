#!/system/bin/sh
# MaxRegnerOS Systemless SystemUI & Framework Late-Start Service
# Executed automatically by Magisk boot sequence on Stock Android 12 Moto G22 (hawaiipl)

MODDIR=${0%/*}
MAXROOT="/data/adb/maxregneros"

# Wait for Android boot completion
until [ "$(getprop sys.boot_completed)" = "1" ]; do
    sleep 2
done

# Register MaxRegnerOS System Property Overrides
resetprop ro.product.model "MaxRegnerOS CyberPhone (hawaiipl)"
resetprop ro.product.brand "MaxRegner"
resetprop ro.product.manufacturer "MaxRegnerOS"
resetprop ro.build.display.id "MaxRegnerOS-1.0-ULTRA-Cyberhawaii"
resetprop ro.build.version.release "12-MaxRegnerOS"
resetprop ro.maxregneros.version "1.0-ULTRA"

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

echo "[MaxRegnerOS Service] SystemUI & Framework Overrides Active."
