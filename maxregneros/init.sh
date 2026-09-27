#!/bin/sh
# MaxRegnerOS Boot Orchestrator & Userspace Init
# Target: Motorola Moto G22 (hawaiipl - MediaTek MT6765 ARM64)
# Running on Stock Moto G22 Linux Kernel

export OS_NAME="MaxRegnerOS"
export OS_CODENAME="Cyberhawaii Mobile"
export OS_VERSION="1.0-ULTRA"
export DEVICE="Motorola Moto G22 (hawaiipl)"
export ARCH="arm64"
export PATH="/maxregneros/bin:/bin:/sbin:/usr/bin:/usr/sbin:$PATH"

echo "=========================================================="
echo "      ___ ___ _______ X ____  ____ ____ _  _ _____ ____ "
echo "      |  |  | | |_| |   |___| |___ | __ |\ | |____ |  | "
echo "      |  |  | |  |  |   |\    |___ |__| | \| |____ |__| "
echo "=========================================================="
echo "    MaxRegnerOS Mobile Linux v${OS_VERSION} [UserData Direct Boot]"
echo "    Target: ${DEVICE} [MediaTek MT6765 / Helio G37]"
echo "    Kernel: Stock Moto G22 Kernel (No Kernel Modifications)"
echo "=========================================================="

# Mount Essential Pseudo Filesystems
echo "[MaxRegnerOS] Mounting core pseudo-filesystems..."
mkdir -p /proc /sys /dev /dev/pts /tmp /mnt /data /system /maxregneros/bin

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

# Initialize MaxRegnerOS Hardware Controllers & Governors
if [ -f /maxregneros/maxregneros_control.sh ]; then
    echo "[MaxRegnerOS] Initializing hardware drivers & governors..."
    /bin/sh /maxregneros/maxregneros_control.sh init 2>/dev/null || true
fi

echo "[MaxRegnerOS Mobile] Boot orchestrator sequence complete."
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
