#!/bin/sh
# MaxProp - MaxRegnerOS Real Android & Linux System Property Utility
# Interacts with Android system properties and Linux sysctl/sysfs parameters on Moto G22 (hawaiipl)

PROPERTY="$1"
VALUE="$2"

get_prop() {
    PROP_NAME="$1"
    if command -v getprop >/dev/null 2>&1; then
        getprop "$PROP_NAME"
    elif [ -f /sys/module/firmware_class/parameters/path ]; then
        cat /sys/module/firmware_class/parameters/path 2>/dev/null
    else
        case "$PROP_NAME" in
            ro.product.model) echo "Moto G22" ;;
            ro.product.device) echo "hawaiipl" ;;
            ro.board.platform) echo "mt6765" ;;
            ro.hardware) echo "mt6765" ;;
            ro.build.version.release) echo "12 (MaxRegnerOS Hybrid)" ;;
            *) echo "" ;;
        esac
    fi
}

set_prop() {
    PROP_NAME="$1"
    PROP_VAL="$2"
    if command -v setprop >/dev/null 2>&1; then
        setprop "$PROP_NAME" "$PROP_VAL"
    else
        echo "[MaxProp] Set $PROP_NAME=$PROP_VAL"
    fi
}

if [ -z "$PROPERTY" ]; then
    echo "Usage: maxprop [property_name] [value]"
    echo "Common Properties:"
    echo "  ro.product.model       - Device Model"
    echo "  ro.product.device      - Device Codename (hawaiipl)"
    echo "  ro.board.platform     - Chipset Platform (mt6765)"
    echo "  ro.build.version.release - System Version"
elif [ -n "$VALUE" ]; then
    set_prop "$PROPERTY" "$VALUE"
else
    get_prop "$PROPERTY"
fi
