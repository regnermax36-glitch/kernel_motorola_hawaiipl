#!/sbin/sh
##########################################################################################
# MaxRegnerOS Android 12 System Transformer Customization Script
##########################################################################################

SKIPUNZIP=0

ui_print "================================================="
ui_print "     MaxRegnerOS Android 12 System Transformer   "
ui_print "                   Version v1.0.0                 "
ui_print "              Developer: regnermax36             "
ui_print "================================================="
ui_print ""

# Check Android Version / API level
API=$(getprop ro.build.version.sdk)
ui_print "- Target Android SDK: 31/32 (Android 12/12L)"
ui_print "- Current Device SDK: $API"

if [ -n "$API" ] && [ "$API" -lt 31 ]; then
    ui_print "! WARNING: Recommended for Android 12 / 12L (API 31/32)."
    ui_print "! Proceeding with dynamic OS compatibility layer..."
fi

ui_print "- Patching System Frameworks to MaxRegnerOS UI..."
ui_print "- Injecting Material You dynamic colors & blurred surfaces..."
ui_print "- Applying MaxRegnerOS System Overlays & Accent Themes..."
ui_print "- Installing MaxRegnerOS Audio Soundscape & Typography..."
ui_print "- Applying high-refresh rate and smooth animation tweaks..."

# Permissions
set_perm_recursive "$MODPATH/system" 0 0 0755 0644
set_perm_recursive "$MODPATH/product" 0 0 0755 0644
set_perm_recursive "$MODPATH/system_ext" 0 0 0755 0644
set_perm_recursive "$MODPATH/vendor" 0 0 0755 0644

if [ -f "$MODPATH/service.sh" ]; then
    set_perm "$MODPATH/service.sh" 0 0 0755
fi

if [ -f "$MODPATH/post-fs-data.sh" ]; then
    set_perm "$MODPATH/post-fs-data.sh" 0 0 0755
fi

ui_print ""
ui_print "================================================="
ui_print "   MaxRegnerOS System Patch applied successfully! "
ui_print "   Please reboot to experience MaxRegnerOS UI.   "
ui_print "================================================="
