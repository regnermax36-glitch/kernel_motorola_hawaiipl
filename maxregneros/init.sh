#!/bin/sh
# MaxRegnerOS Hybrid Boot Orchestrator & PivotRoot Init
# Target: Motorola Moto G22 (hawaiipl - MediaTek MT6765 ARM64)
# Merged Linux & Android Environment Architecture

export OS_NAME="MaxRegnerOS Hybrid"
export OS_CODENAME="Cyberhawaii Mobile"
export OS_VERSION="1.0-ULTRA"
export DEVICE="Motorola Moto G22 (hawaiipl)"
export ARCH="arm64"
export ANDROID_ROOT="/system"
export ANDROID_DATA="/data"
export PATH="/maxregneros/bin:/bin:/sbin:/usr/bin:/usr/sbin:/system/bin:/vendor/bin:$PATH"
export LD_LIBRARY_PATH="/maxregneros/lib64:/system/lib64:/vendor/lib64:$LD_LIBRARY_PATH"

echo "=========================================================="
echo "      ___ ___ _______ X ____  ____ ____ _  _ _____ ____ "
echo "      |  |  | | |_| |   |___| |___ | __ |\ | |____ |  | "
echo "      |  |  | |  |  |   |\    |___ |__| | \| |____ |__| "
echo "=========================================================="
echo "    MaxRegnerOS Merged Linux + Android v${OS_VERSION}"
echo "    Target: ${DEVICE} [MediaTek MT6765 / Helio G37]"
echo "    Kernel: Stock Moto G22 Kernel (UserData Boot Active)"
echo "=========================================================="

# Mount Essential Pseudo Filesystems & HAL Overlays
echo "[MaxRegnerOS] Mounting core pseudo-filesystems & Android HAL overlays..."
mkdir -p /proc /sys /dev /dev/pts /dev/socket /dev/binderfs /tmp /mnt /data /system /vendor /apex /linkerconfig /maxregneros/bin

if ! mountpoint -q /proc 2>/dev/null; then
    mount -t proc proc /proc 2>/dev/null || true
fi

if ! mountpoint -q /sys 2>/dev/null; then
    mount -t sysfs sysfs /sys 2>/dev/null || true
fi

if ! mountpoint -q /dev 2>/dev/null; then
    mount -t devtmpfs devtmpfs /dev 2>/dev/null || mount -t tmpfs tmpfs /dev 2>/dev/null || true
fi

if ! mountpoint -q /dev/pts 2>/dev/null; then
    mkdir -p /dev/pts
    mount -t devpts devpts /dev/pts 2>/dev/null || true
fi

if ! mountpoint -q /tmp 2>/dev/null; then
    mount -t tmpfs tmpfs /tmp 2>/dev/null || true
fi

# Set hostname
hostname "maxregneros" 2>/dev/null || true

# Initialize MaxRegnerOS Hardware Governors
if [ -f /maxregneros/maxregneros_control.sh ]; then
    echo "[MaxRegnerOS] Initializing MT6765 hardware drivers & governors..."
    /bin/sh /maxregneros/maxregneros_control.sh init 2>/dev/null || true
fi

echo "[MaxRegnerOS Hybrid] Boot orchestrator sequence complete."
echo ""

# Launch MaxRegnerOS Mobile Shell
if [ -f /maxregneros/maxregneros_shell.sh ]; then
    exec /bin/sh /maxregneros/maxregneros_shell.sh
elif [ -f /bin/sh ]; then
    exec /bin/sh
else
    echo "[ERROR] No shell found!"
    exit 1
fi
