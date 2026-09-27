#!/system/bin/sh
# MaxRegnerOS Magisk Module Installation Customizer

ui_print "=========================================================="
ui_print "  Installing MaxRegnerOS Mobile Linux for Moto G22"
ui_print "=========================================================="
ui_print " Target: Motorola Moto G22 (hawaiipl - MT6765)"
ui_print " Mode:   Systemless Magisk Module (Stock Android 12)"
ui_print "=========================================================="

MAXROOT="/data/adb/maxregneros"
rm -rf "$MAXROOT"
mkdir -p "$MAXROOT"

ui_print "- Unpacking Alpine ARM64 Linux RootFS into $MAXROOT..."
if [ -f "$MODPATH/maxregneros_rootfs.tar.gz" ]; then
    tar -xzf "$MODPATH/maxregneros_rootfs.tar.gz" -C "$MAXROOT"
    rm -f "$MODPATH/maxregneros_rootfs.tar.gz"
fi

# Set executable permissions
chmod 755 "$MODPATH/service.sh" 2>/dev/null || true
chmod 755 "$MODPATH/system/bin/"* 2>/dev/null || true

ui_print "- Installation complete! Reboot or type 'maxregneros' in terminal."
