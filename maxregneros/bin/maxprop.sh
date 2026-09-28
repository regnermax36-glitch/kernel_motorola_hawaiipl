#!/bin/sh
# MaxProp - MaxRegnerOS System Property Override Engine
# Transforms system properties to MaxRegnerOS Mobile Linux on Moto G22 (hawaiipl)

PROPERTY="$1"
VALUE="$2"

get_prop() {
    PROP_NAME="$1"
    if command -v getprop >/dev/null 2>&1; then
        VAL=$(getprop "$PROP_NAME" 2>/dev/null)
        if [ -n "$VAL" ]; then
            echo "$VAL"
            return
        fi
    fi

    case "$PROP_NAME" in
        ro.product.model|ro.product.system.model) echo "MaxRegnerOS CyberPhone (hawaiipl)" ;;
        ro.product.device|ro.product.system.device) echo "hawaiipl" ;;
        ro.product.brand) echo "MaxRegner" ;;
        ro.product.manufacturer) echo "MaxRegnerOS" ;;
        ro.board.platform) echo "mt6765" ;;
        ro.hardware) echo "mt6765" ;;
        ro.build.display.id) echo "MaxRegnerOS-1.0-ULTRA-Cyberhawaii" ;;
        ro.build.version.release) echo "12-MaxRegnerOS" ;;
        ro.maxregneros.version) echo "1.0-ULTRA" ;;
        *) echo "" ;;
    esac
}

set_prop() {
    PROP_NAME="$1"
    PROP_VAL="$2"
    if command -v setprop >/dev/null 2>&1; then
        setprop "$PROP_NAME" "$PROP_VAL" 2>/dev/null || true
    fi
    echo "[MaxProp Override] Set $PROP_NAME = $PROP_VAL"
}

if [ -z "$PROPERTY" ]; then
    echo "=========================================================="
    echo "  MaxProp - MaxRegnerOS System Property Engine"
    echo "=========================================================="
    echo "Usage: maxprop <property_name> [value]"
    echo ""
    echo "Active Overrides:"
    echo "  Model:        $(get_prop ro.product.model)"
    echo "  Device:       $(get_prop ro.product.device)"
    echo "  Display ID:   $(get_prop ro.build.display.id)"
    echo "  OS Version:   $(get_prop ro.build.version.release)"
    echo "=========================================================="
elif [ -n "$VALUE" ]; then
    set_prop "$PROPERTY" "$VALUE"
else
    get_prop "$PROPERTY"
fi
