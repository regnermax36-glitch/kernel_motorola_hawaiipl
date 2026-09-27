#!/bin/sh
# MaxRegnerOS Boot Orchestrator & Userspace Init
# Target: Motorola Moto G22 (hawaiipl - MediaTek MT6765 ARM64)

export OS_NAME="MaxRegnerOS"
export OS_CODENAME="Cyberhawaii"
export OS_VERSION="1.0-ULTRA"
export DEVICE="Motorola Moto G22 (hawaiipl)"
export ARCH="arm64"
export PATH="/bin:/sbin:/usr/bin:/usr/sbin:/maxregneros/bin:$PATH"

echo "=========================================================="
echo "      ___ ___ _______ X ____  ____ ____ _  _ _____ ____ "
echo "      |  |  | | |_| |   |___| |___ | __ |\ | |____ |  | "
echo "      |  |  | |  |  |   |\    |___ |__| | \| |____ |__| "
echo "=========================================================="
echo "       MaxRegnerOS v${OS_VERSION} - ARM64 Next-Gen Linux OS"
echo "       Hardware: ${DEVICE} [MediaTek MT6765 / Helio G37]"
echo "=========================================================="

# Mount Essential Pseudo Filesystems
echo "[MaxRegnerOS] Initializing core filesystems..."
mkdir -p /proc /sys /dev /dev/pts /tmp /mnt /data /system

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

# Hostname setup
hostname "maxregneros" 2>/dev/null || true

# Initialize MaxRegnerOS Hardware Controllers
if [ -f /maxregneros/maxregneros_control.sh ]; then
    echo "[MaxRegnerOS] Initializing hardware drivers & governors..."
    /bin/sh /maxregneros/maxregneros_control.sh init 2>/dev/null || true
fi

echo "[MaxRegnerOS] Boot sequence completed successfully!"
echo ""

# Launch MaxRegnerOS Shell
if [ -f /maxregneros/maxregneros_shell.sh ]; then
    exec /bin/sh /maxregneros/maxregneros_shell.sh
elif [ -f /bin/sh ]; then
    exec /bin/sh
else
    echo "[ERROR] No shell found!"
    exit 1
fi
