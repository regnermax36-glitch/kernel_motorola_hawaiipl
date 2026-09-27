# MaxRegnerOS v1.0-ULTRA Mobile Linux
### Next-Gen ARM64 Mobile Linux OS for Motorola Moto G22 (`hawaiipl`)
**SoC:** MediaTek MT6765 / Helio G37 | **Arch:** ARM64 (aarch64) | **Kernel Mode:** Stock Moto G22 Kernel | **Flash Format:** UserData Partition Direct Boot

---

## 🚀 Overview

**MaxRegnerOS Mobile Linux** is an ARM64 Linux OS distribution layer designed for the **Motorola Moto G22** (`hawaiipl`).
It runs **100% on the stock Motorola Moto G22 kernel** without requiring any kernel code modifications, and boots directly from the `/userdata` partition.

---

## 📦 Direct Image Download Link (Uploaded to temp.sh)

- **Temp.sh Direct Download Link:** [https://temp.sh/WGdQx/maxregneros_userdata.img.tar.gz](https://temp.sh/WGdQx/maxregneros_userdata.img.tar.gz)
- **Build Tooling:** `./tools/build_maxregneros_img.sh` generates a populated `maxregneros_userdata.img` ext4 filesystem using `mkfs.ext4 -d`.

---

## 🔥 Key Features & Capabilities

1. **Zero-Kernel Modification Direct Boot (`maxregneros_userdata.img`):**
   - Flashable directly to `/userdata` via `fastboot flash userdata maxregneros_userdata.img`.
   - Boots directly on the stock Motorola Moto G22 Linux 4.19 kernel (`hawaiipl-perd_defconfig`).

2. **Native C Init Orchestrator (`init.c`):**
   - Cross-compiled ARM64 freestanding C init source (`maxregneros/src/init.c`) that mounts essential pseudo-filesystems (`/proc`, `/sys`, `/dev`), sets environment paths, and launches the shell.

3. **MaxGUI Mobile Touch Desktop Framework (`maxgui`):**
   - Touch-screen graphical window/desktop environment displaying real-time memory usage, battery metrics, thermal zone stats, and fast application shortcuts.

4. **MaxPack Mobile Package Manager (`maxpack`):**
   - Package manager (`maxpack install`, `maxpack remove`, `maxpack list`, `maxpack update`) for fetching and unpacking ARM64 Linux package archives.

5. **MaxRegnerOS Cyber Mobile Shell (`maxregneros_shell.sh`):**
   - Interactive Cyberpunk terminal shell with live theme toggling (`theme`), hardware diagnostics (`devstat`), and thermal monitoring (`thermal`).

6. **Hardware Controller & Governor Suite (`maxregneros_control.sh`):**
   - **CyberBoost Mode (`boost`):** Locks all 8 ARM Cortex-A53 CPU cores to maximum clock speed and tunes VM memory parameters for heavy multitasking.
   - **Eco Mode (`eco`):** Powersave governor activation for extended battery runtime.
   - **Balanced Mode (`balanced`):** Schedutil governor activation.

---

## ⚡ Flashing & Installation Guide

1. **Build UserData Image (Optional - Prebuilt Available via temp.sh link):**
   ```bash
   ./tools/build_maxregneros_img.sh
   ```

2. **Reboot Motorola Moto G22 into Fastboot Mode:**
   ```bash
   adb reboot bootloader
   ```

3. **Flash MaxRegnerOS UserData Image:**
   ```bash
   fastboot flash userdata maxregneros_userdata.img
   ```

4. **Reboot into MaxRegnerOS Mobile Linux:**
   ```bash
   fastboot reboot
   ```

---

## 💻 CLI & Mobile Tools Reference

| Command | Description |
| :--- | :--- |
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
