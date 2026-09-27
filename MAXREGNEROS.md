# MaxRegnerOS v1.0-ULTRA Stock Android 12 Mobile Linux
### Next-Gen Merged ARM64 OS for Motorola Moto G22 (`hawaiipl`)
**SoC:** MediaTek MT6765 / Helio G37 | **Arch:** ARM64 (aarch64) | **Firmware Mode:** Stock Android 12 Firmware & Stock boot.img | **Flash Format:** UserData Partition Direct Boot (`.img`)

---

## 🚀 Overview

**MaxRegnerOS Mobile Linux** is a full genuine ARM64 (`aarch64`) operating system layer for the **Motorola Moto G22** (`hawaiipl`).
It runs **100% natively on Stock Android 12 Firmware and Stock boot.img** without kernel or boot partition modifications, booting directly from the `/userdata` partition as a raw `.img` ext4 filesystem.

---

## 📦 Direct `.img` File Download Link (Uploaded to temp.sh)

- **Raw UserData `.img` Direct Download Link:** [https://temp.sh/wKVsh/maxregneros_userdata.img](https://temp.sh/wKVsh/maxregneros_userdata.img)
- **Build Tooling:** `./tools/build_maxregneros_img.sh` generates a populated `maxregneros_userdata.img` ext4 raw image containing the full merged Linux + Android ARM64 rootfs using `mkfs.ext4 -d`.

---

## 🔥 Key Features & Capabilities

1. **Stock Android 12 & Stock Boot Compatibility:**
   - Runs directly on Stock Moto G22 Android 12 Firmware without requiring custom kernel compilation or boot partition flashing.

2. **Native Launcher (`start.sh`):**
   - Native launcher script (`/maxregneros/start.sh`) that mounts Linux pseudo-filesystems (`/proc`, `/sys`, `/dev`), sets environment paths, and initializes the environment on stock Android 12.

3. **Raw UserData Partition Image (`maxregneros_userdata.img`):**
   - Direct raw `.img` file (128MB populated ext4 filesystem) ready to flash via `fastboot flash userdata maxregneros_userdata.img`.

4. **Merged Linux & Android ARM64 RootFS:**
   - Full Alpine Linux v3.19 ARM64 userland (`/bin/busybox`, `/lib/ld-musl-aarch64.so.1`) integrated with Android system library paths (`/system/lib64`, `/vendor/lib64`) and socket interfaces (`/dev/socket`).

5. **Android Property & Service Bridge (`maxprop` & `maxsvc`):**
   - `maxprop` utility for querying/setting Android system properties (`ro.product.model`, `ro.product.device`, `ro.board.platform`).
   - `maxsvc` utility for listing and querying Android Binder / HAL services (`servicemanager`, `hwservicemanager`, `surfaceflinger`).

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
   curl -L "https://temp.sh/wKVsh/maxregneros_userdata.img" -o maxregneros_userdata.img
   ```

2. **Reboot Motorola Moto G22 into Fastboot Mode:**
   ```bash
   adb reboot bootloader
   ```

3. **Flash Raw MaxRegnerOS UserData Image File:**
   ```bash
   fastboot flash userdata maxregneros_userdata.img
   ```

4. **Reboot into Stock Android 12 & Start MaxRegnerOS Environment:**
   ```bash
   fastboot reboot
   ```

5. **Start MaxRegnerOS Session:**
   ```bash
   adb shell /userdata/start.sh
   ```

---

## 💻 CLI & Mobile Tools Reference

| Command | Description |
| :--- | :--- |
| `start.sh` | Stock Android 12 launcher script |
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

*MaxRegnerOS Mobile Linux - Motorola Moto G22 (`hawaiipl`)*
