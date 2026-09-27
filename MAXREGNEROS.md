# MaxRegnerOS v1.0-ULTRA (Cyberhawaii)
### Next-Gen ARM64 Linux OS for Motorola Moto G22 (`hawaiipl`)
**SoC:** MediaTek MT6765 / Helio G37 | **Arch:** ARM64 (aarch64) | **Flash Format:** UserData Partition Direct Boot

---

## 🚀 Overview

**MaxRegnerOS** is a specialized, ultra-performance ARM64 Linux OS built for the **Motorola Moto G22** (`hawaiipl`). It brings a futuristic cyber-interface, low-latency kernel configuration, and a lightweight standalone userspace architecture designed to boot cleanly from the `/userdata` partition.

---

## 🔥 Key Features

1. **Direct UserData Flashability (`maxregneros_userdata.img`):**
   - Flashable directly to the phone's `/userdata` partition via `fastboot flash userdata maxregneros_userdata.img`.
   - Leaves standard system/vendor partitions intact while running a complete, isolated Linux OS.

2. **Dedicated Kernel Configuration (`maxregneros_defconfig`):**
   - Custom Linux 4.19 kernel defconfig based on `hawaiipl-perd_defconfig`.
   - Hostname set to `maxregneros` and LOCALVERSION tagged as `-MaxRegnerOS`.
   - Pre-configured scheduler interop for MediaTek MT6765 8x Cortex-A53 cores.

3. **Interactive MaxRegnerOS Cyber Shell (`maxregneros_shell.sh`):**
   - Cyberpunk terminal interface with color customization (`theme`).
   - Integrated hardware monitoring: `sysinfo`, `devstat`, `thermal`.
   - Animated stream utility: `matrix`.

4. **Hardware Controller Suite (`maxregneros_control.sh`):**
   - **CyberBoost Mode (`boost`):** Forces CPU governor to maximum performance across all 8 cores and tunes VM swappiness for heavy workloads.
   - **Eco Mode (`eco`):** Powersave governor activation for extended battery runtime.
   - **Schedutil Mode (`balanced`):** Dynamic load-balancing frequency scaling.

5. **Standalone Boot Orchestrator (`init.sh`):**
   - Mounts `/proc`, `/sys`, `/dev`, `/dev/pts`, `/tmp`.
   - Configures hostname and environment paths.
   - Launches `maxregneros_shell.sh` automatically upon boot.

---

## 🛠️ Building Kernel & UserData Image

### 1. Build the Kernel for Motorola Moto G22 (`hawaiipl`)

```bash
# Set cross-compiler environment
export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-android-

# Load MaxRegnerOS kernel configuration
make maxregneros_defconfig

# Build kernel Image.gz-dtb / Image
make -j$(nproc)
```

### 2. Build the UserData Image (`maxregneros_userdata.img`)

```bash
# Execute MaxRegnerOS image builder tool
./tools/build_maxregneros_img.sh
```

This generates `maxregneros_userdata.img` (64MB flashable ext4 image).

---

## ⚡ Installation & Flashing Instructions

1. **Reboot Motorola Moto G22 into Fastboot Mode:**
   ```bash
   adb reboot bootloader
   ```

2. **Flash MaxRegnerOS Kernel to Boot Partition:**
   ```bash
   fastboot flash boot arch/arm64/boot/Image.gz-dtb
   ```

3. **Flash MaxRegnerOS UserData Image to UserData Partition:**
   ```bash
   fastboot flash userdata maxregneros_userdata.img
   ```

4. **Boot into MaxRegnerOS:**
   ```bash
   fastboot reboot
   ```

---

## 💻 MaxRegnerOS CLI Reference

| Command | Description |
| :--- | :--- |
| `sysinfo` | Displays OS build, CPU cores, RAM, and architecture breakdown |
| `devstat` | Displays Motorola Moto G22 hardware diagnostics & CPU governors |
| `thermal` | Reads MediaTek MT6765 SoC thermal sensors |
| `boost` | Activates CyberBoost performance governor on all 8 Cortex-A53 cores |
| `eco` | Activates Eco powersave governor |
| `matrix` | Launches Cyberpunk digital stream |
| `features` | Lists unique MaxRegnerOS architectural features |
| `theme` | Changes UI color palette |
| `clear` | Clears terminal screen and re-renders MaxRegnerOS ASCII banner |
| `exit` | Exits the interactive shell session |

---

*MaxRegnerOS - Next-Generation ARM64 Linux OS for Motorola Moto G22 (`hawaiipl`)*
