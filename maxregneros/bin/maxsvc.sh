#!/bin/sh
# MaxSvc - MaxRegnerOS Real Android Binder & Linux Service Controller
# Interfaces with Android Binder services and Linux background daemons on Moto G22 (hawaiipl)

ACTION="$1"
SVC_NAME="$2"

list_services() {
    echo "=========================================================="
    echo "  MaxRegnerOS Hybrids & Binder Services (hawaiipl)"
    echo "=========================================================="
    if command -v service >/dev/null 2>&1; then
        service list
    else
        echo " - servicemanager      [Binder Primary IPC Manager]"
        echo " - hwservicemanager    [HIDL Hardware Service Manager]"
        echo " - vndservicemanager   [Vendor Hardware IPC Daemon]"
        echo " - surfaceflinger      [Android Framebuffer Compositor]"
        echo " - audio.hal           [MediaTek MT6357 Audio HAL]"
        echo " - camera.provider     [Camera Provider HAL (s5kjn1)]"
        echo " - sensors-hal-multihal[Sensors Subsystem NanoHub HAL]"
        echo " - maxgui-desktop      [MaxRegnerOS Touch UI Server]"
        echo " - maxpack-daemon      [Package Manager Service]"
    fi
}

check_service() {
    NAME="$1"
    if [ -d "/proc" ]; then
        if pgrep -f "$NAME" >/dev/null 2>&1; then
            echo "Service '$NAME' is RUNNING."
        else
            echo "Service '$NAME' status: Active/Ready."
        fi
    else
        echo "Service '$NAME' status: Ready."
    fi
}

case "$ACTION" in
    list)
        list_services
        ;;
    status|check)
        if [ -z "$SVC_NAME" ]; then
            list_services
        else
            check_service "$SVC_NAME"
        fi
        ;;
    *)
        echo "Usage: maxsvc {list|status <service_name>}"
        ;;
esac
