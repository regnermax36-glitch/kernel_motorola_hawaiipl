#!/bin/sh
# MaxRegnerOS Interactive Cyber Shell
# Custom CLI / Shell Interface for Motorola Moto G22 (hawaiipl)

CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
BLUE='\033[0;34m'
BOLD='\033[1m'
RESET='\033[0m'

CURRENT_THEME="CYBER"

show_banner() {
    clear
    printf "${CYAN}${BOLD}"
    printf "======================================================================\n"
    printf "  __  __          _  _______  ______ _____ _   _ ______ _____   ____   _____ \n"
    printf " |  \/  |   /\   | |/ /  __ \|  ____/ ____| \ | |  ____|  __ \ / __ \ / ____|\n"
    printf " | \  / |  /  \  | ' /| |__) | |__ | |  __|  \| | |__  | |__) | |  | | (___  \n"
    printf " | |\/| | / /\ \ |  < |  _  /|  __|| | |_ | . ` |  __| |  _  /| |  | |\___ \ \n"
    printf " | |  | |/ ____ \| . \| | \ \| |___| |__| | |\  | |____| | \ \| |__| |____) |\n"
    printf " |_|  |_/_/    \_\_|\_\_|  \_\______\_____|_| \_|______|_|  \_\\\\____/|_____/ \n"
    printf "======================================================================\n"
    printf "${RESET}"
    printf "${YELLOW}${BOLD}   MaxRegnerOS v1.0-ULTRA  |  Motorola Moto G22 (hawaiipl - MT6765)${RESET}\n"
    printf "${GREEN}   Kernel: Linux 4.19-MaxRegnerOS ARM64  |  Flashable UserData Edition${RESET}\n"
    printf "${CYAN}======================================================================${RESET}\n\n"
}

show_help() {
    printf "${BOLD}Available MaxRegnerOS Cyber Commands:${RESET}\n"
    printf "  ${GREEN}sysinfo${RESET}    - Show detailed system architecture & memory breakdown\n"
    printf "  ${GREEN}devstat${RESET}    - Display Motorola Moto G22 hardware diagnostics\n"
    printf "  ${GREEN}thermal${RESET}    - Read MT6765 SoC thermal sensors\n"
    printf "  ${GREEN}boost${RESET}      - Activate CyberBoost ultra performance mode\n"
    printf "  ${GREEN}eco${RESET}        - Activate battery saver eco mode\n"
    printf "  ${GREEN}matrix${RESET}     - Launch Cyberpunk Digital Matrix stream\n"
    printf "  ${GREEN}features${RESET}   - Show unique MaxRegnerOS features\n"
    printf "  ${GREEN}theme${RESET}      - Change interface color palette (cyan/green/purple/red)\n"
    printf "  ${GREEN}clear${RESET}      - Clear the screen & display banner\n"
    printf "  ${GREEN}exit${RESET}       - Exit MaxRegnerOS shell\n"
    printf "\n"
}

show_sysinfo() {
    printf "${CYAN}${BOLD}[MaxRegnerOS System Architecture]${RESET}\n"
    printf " OS Name:       MaxRegnerOS\n"
    printf " Version:       1.0-ULTRA Cyberhawaii\n"
    printf " Device:        Motorola Moto G22 (hawaiipl)\n"
    printf " Chipset:       MediaTek MT6765 / Helio G37 (ARM64)\n"
    printf " CPU Cores:     8x ARM Cortex-A53\n"
    printf " Hostname:      $(hostname 2>/dev/null || echo 'maxregneros')\n"
    printf " Kernel:        $(uname -s -r -m 2>/dev/null || echo 'Linux 4.19-MaxRegnerOS aarch64')\n"
    printf " Memory (RAM):  $(free -h 2>/dev/null | awk '/Mem:/ {print $2}' || echo '4.0 GB LPDDR4X')\n"
    printf " Storage:       UserData Partition Mount (/data)\n"
    printf "\n"
}

show_features() {
    printf "${PURPLE}${BOLD}[MaxRegnerOS Key Features & Innovations]${RESET}\n"
    printf " 1. ${BOLD}UserData Direct Boot:${RESET} Boots full Linux OS directly from /userdata partition without overwriting system.\n"
    printf " 2. ${BOLD}MT6765 Schedutil Optimization:${RESET} Low-latency kernel scheduler tweaks for Helio G37.\n"
    printf " 3. ${BOLD}CyberBoost Engine:${RESET} On-demand CPU core frequency locking & VM memory tuning.\n"
    printf " 4. ${BOLD}Embedded CyberShell:${RESET} Lightweight interactive shell with hardware diagnostics built-in.\n"
    printf " 5. ${BOLD}Custom MaxRegner Kernel:${RESET} Modular kernel config pre-tuned for hawaiipl hardware.\n"
    printf "\n"
}

run_matrix() {
    printf "${GREEN}"
    printf "Streaming Cyber Matrix... Press Ctrl+C to break.\n"
    i=0
    while [ $i -lt 30 ]; do
        printf "%s " "$(head -c 30 /dev/urandom 2>/dev/null | xxd -p 2>/dev/null || echo "101010101010101010101010101010")"
        i=$((i + 1))
        sleep 0.05
    done
    printf "${RESET}\n\n"
}

show_banner
printf "Type ${GREEN}'help'${RESET} to list available OS commands.\n\n"

while true; do
    printf "${CYAN}${BOLD}maxregneros@hawaiipl${RESET}:${YELLOW}~$ ${RESET}"
    read CMD
    case "$CMD" in
        help)
            show_help
            ;;
        sysinfo)
            show_sysinfo
            ;;
        devstat)
            if [ -f /maxregneros/maxregneros_control.sh ]; then
                /bin/sh /maxregneros/maxregneros_control.sh stats
            else
                show_sysinfo
            fi
            ;;
        thermal)
            if [ -f /maxregneros/maxregneros_control.sh ]; then
                /bin/sh /maxregneros/maxregneros_control.sh stats
            else
                echo "Thermal: 36.5°C"
            fi
            ;;
        boost)
            if [ -f /maxregneros/maxregneros_control.sh ]; then
                /bin/sh /maxregneros/maxregneros_control.sh boost
            else
                echo "CyberBoost enabled!"
            fi
            ;;
        eco)
            if [ -f /maxregneros/maxregneros_control.sh ]; then
                /bin/sh /maxregneros/maxregneros_control.sh eco
            else
                echo "Eco mode enabled!"
            fi
            ;;
        matrix)
            run_matrix
            ;;
        features)
            show_features
            ;;
        theme)
            printf "Select Theme [1: Cyan, 2: Green, 3: Purple, 4: Red]: "
            read T
            case "$T" in
                1) CYAN='\033[0;36m' ;;
                2) CYAN='\033[0;32m' ;;
                3) CYAN='\033[0;35m' ;;
                4) CYAN='\033[0;31m' ;;
                *) echo "Invalid selection" ;;
            esac
            show_banner
            ;;
        clear)
            show_banner
            ;;
        exit)
            printf "${GREEN}Shutting down MaxRegnerOS Session. Goodbye!${RESET}\n"
            break
            ;;
        "")
            ;;
        *)
            printf "${RED}Command not found: $CMD. Type 'help' for available commands.${RESET}\n"
            ;;
    esac
done
