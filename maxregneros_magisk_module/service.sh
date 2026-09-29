#!/system/bin/sh
# MaxRegnerOS late-start service script

MODDIR=${0%/*}

# Wait for boot completion
until [ "$(getprop sys.boot_completed)" = "1" ]; do
    sleep 5
done

# Apply MaxRegnerOS Android 12 System Settings & UI Tweaks
settings put system maxregneros_ui_enabled 1 2>/dev/null
settings put system status_bar_show_battery_percent 1 2>/dev/null
settings put system lockscreen_sounds_enabled 1 2>/dev/null
settings put secure ui_night_mode 2 2>/dev/null
settings put global window_animation_scale 0.8 2>/dev/null
settings put global transition_animation_scale 0.8 2>/dev/null
settings put global animator_duration_scale 0.8 2>/dev/null

# Enable MaxRegnerOS gesture bar navigation & dynamic UI rounded corners
settings put secure navigation_mode 2 2>/dev/null
settings put system custom_ui_rounded_corners 16 2>/dev/null

# Safely enable overlays if present in OverlayManager
for overlay_pkg in com.maxregneros.overlay.framework com.maxregneros.overlay.systemui com.maxregneros.overlay.settings; do
    if cmd overlay list | grep -q "$overlay_pkg"; then
        cmd overlay enable "$overlay_pkg" 2>/dev/null
    fi
done
