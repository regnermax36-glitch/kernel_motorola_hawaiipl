#!/system/bin/sh
# MaxRegnerOS post-fs-data script

MODDIR=${0%/*}

# Override device branding & OS characteristics to MaxRegnerOS
resetprop ro.maxregneros.version "v1.0.0-PRO"
resetprop ro.maxregneros.edition "MaxRegnerOS Android 12 Experience"
resetprop ro.maxregneros.ui "Material You NextGen"
resetprop ro.maxregneros.build.date "$(date)"

# Transform OS Brand & Model Info for MaxRegnerOS UI identification
resetprop ro.build.display.id "MaxRegnerOS-12.0.0-RELEASE"
resetprop ro.build.version.incremental "MaxRegnerOS-v1.0"
resetprop ro.build.flavor "maxregneros_arm64-user"
resetprop ro.config.media_vol_steps 30
resetprop ro.config.vc_call_vol_steps 15

# UI Surface Blur & Render Engine Enhancements
resetprop ro.surface_flinger.supports_background_blur 1
resetprop debug.sf.disable_backpressure 1
resetprop debug.sf.enable_gl_backpressure 0
resetprop debug.sf.latch_unsignaled 1
resetprop persist.sys.sf.color_saturation 1.1

# Enable MaxRegnerOS Custom UI & Performance flags
resetprop ro.launcher.blur.enable true
resetprop persist.sys.theme.accent_color_picker true
resetprop persist.sys.maxregneros.ui_engine 1
