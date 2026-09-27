# MaxRegnerOS v1.0-ULTRA Merged Mobile Linux & Android
### Next-Gen Merged ARM64 OS for Motorola Moto G22 (`hawaiipl`)
**SoC:** MediaTek MT6765 / Helio G37 | **Arch:** ARM64 (aarch64) | **Kernel Mode:** Stock Moto G22 Kernel | **Flash Format:** UserData Partition Direct Boot (`.img`)

---

## 🚀 Overview

**MaxRegnerOS Merged Mobile Linux** is a unified ARM64 (`aarch64`) operating system layer for the **Motorola Moto G22** (`hawaiipl`).
It merges standard Linux filesystem paths (`/etc`, `/bin`, `/lib64`, `/usr`) with Android system paths (`/system`, `/vendor`, `/apex`, `/linkerconfig`, `/data`), running **100% on the stock Motorola Moto G22 kernel** without kernel code modifications, booting directly from the `/userdata` partition as a raw `.img` filesystem.

---

## 📦 Direct `.img` File Download Link (Uploaded to temp.sh)

- **Raw UserData `.img` Direct Download Link:** [https://temp.sh/bUgdE/maxregneros_userdata.img](https://temp.sh/bUgdE/maxregneros_userdata.img)
- **Build Tooling:** `./tools/build_maxregneros_img.sh` generates a populated `maxregneros_userdata.img` ext4 raw image containing the full merged Linux + Android ARM64 rootfs using `mkfs.ext4 -d`.
- **Ramdisk Boot Patcher:** `./tools/patch_boot_img.sh` patches stock `boot.img` ramdisk to mount `/userdata` and launch MaxRegnerOS cleanly.

---

## 🔥 Key Features & Capabilities

1. **Ramdisk Boot Patcher (`tools/patch_boot_img.sh`):**
   - Modifies stock `boot.img` ramdisk to inject `init.maxregneros.rc` and auto-start `/userdata/init.sh` at post-fs-data stage.

2. **Raw UserData Partition Image (`maxregneros_userdata.img`):**
   - Direct raw `.img` file (128MB populated ext4 filesystem) ready to flash via `fastboot flash userdata maxregneros_userdata.img`.
   - Boots directly on the stock Motorola Moto G22 Linux 4.19 kernel (`hawaiipl-perd_defconfig`).

3. **Merged Linux & Android ARM64 RootFS:**
   - Full Alpine Linux v3.19 ARM64 userland (`/bin/busybox`, `/lib/ld-musl-aarch64.so.1`) integrated with Android system library paths (`/system/lib64`, `/vendor/lib64`) and socket interfaces (`/dev/socket`).

4. **Android Property & Service Bridge (`maxprop` & `maxsvc`):**
   - `maxprop` utility for querying/setting Android system properties (`ro.product.model`, `ro.product.device`, `ro.board.platform`).
   - `maxsvc` utility for listing and querying Android Binder / HAL services (`servicemanager`, `hwservicemanager`, `surfaceflinger`).

5. **Native C Init Orchestrator (`init.c`):**
   - Cross-compiled ARM64 freestanding C init source (`maxregneros/src/init.c`) that mounts essential pseudo-filesystems (`/proc`, `/sys`, `/dev`), sets environment paths, and launches the shell.

6. **MaxGUI Mobile Touch Desktop Framework (`maxgui`):**
   - Touch-screen graphical window/desktop environment displaying real-time memory usage, battery metrics, thermal zone stats, and fast application shortcuts.

7. **MaxPack Mobile Package Manager (`maxpack`):**
   - Package manager (`maxpack install`, `maxpack remove`, `maxpack list`, `maxpack update`) for fetching and unpacking ARM64 Linux package archives.

8. **Hardware Controller & Governor Suite (`maxregneros_control.sh`):**
   - **CyberBoost Mode (`boost`):** Locks all 8 ARM Cortex-A53 CPU cores to maximum clock speed and tunes VM memory parameters for heavy multitasking.
   - **Eco Mode (`eco`):** Powersave governor activation for extended battery runtime.
   - **Balanced Mode (`balanced`):** Schedutil governor activation.

---

## ⚡ Flashing & Installation Guide

1. **Download Raw `.img` File:**
   ```bash
   curl -L "https://temp.sh/bUgdE/maxregneros_userdata.img" -o maxregneros_userdata.img
   ```

2. **Patch Stock Boot Image:**
   ```bash
   ./tools/patch_boot_img.sh stock_boot.img patched_boot.img
   ```

3. **Reboot Motorola Moto G22 into Fastboot Mode:**
   ```bash
   adb reboot bootloader
   ```

4. **Flash Patched Boot and UserData Images:**
   ```bash
   fastboot flash boot patched_boot.img
   fastboot flash userdata maxregneros_userdata.img
   ```

5. **Reboot into MaxRegnerOS Merged Mobile Linux:**
   ```bash
   fastboot reboot
   ```

---

## 💻 CLI & Mobile Tools Reference

| Command | Description |
| :--- | :--- |
| `maxprop` | Queries/sets Android & Linux system properties |
| `maxsvc` | Lists and checks status of Binder services & daemons |
| `gui` / `maxgui` | Launches MaxGUI Touch Screen Mobile Desktop UI Framework |
| `maxpack` | Launches MaxPack Mobile Package Manager (`install`, `remove`, `list`, `update`) |
| `sysinfo` | Displays OS build, CPU cores, RAM, and architecture breakdown |
| `devstat` | Displays Motorola Moto G22 hardware diagnostics & CPU governors |
| `thermal` | Reads MediaTek MT6765 SoC thermal sensors |
| `boost` | Activates CyberBoost performance governor on all 8 Cortex-A53 cores |
| `eco` | Activates Eco powersave governor |
| `matrix` | Launches Cyberpunk digital stream |
| `features` | Lists unique MaxRegnerOS Mobile features |
| `theme` | Changes terminal UI color palette |
| `exit` | Exits the interactive shell session |

---

*MaxRegnerOS Merged Mobile Linux - Motorola Moto G22 (`hawaiipl`)*
