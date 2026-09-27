#!/bin/sh
# MaxRegnerOS Interactive Cyber Mobile Shell
# Custom CLI / Mobile Interface for Motorola Moto G22 (hawaiipl)

CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
BLUE='\033[0;34m'
BOLD='\033[1m'
RESET='\033[0m'

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
    printf "${YELLOW}${BOLD}   MaxRegnerOS Mobile v1.0-ULTRA  |  Motorola Moto G22 (hawaiipl)${RESET}\n"
    printf "${GREEN}   Kernel: Stock Moto G22 Kernel  |  Flashable UserData OS Edition${RESET}\n"
    printf "${CYAN}======================================================================${RESET}\n\n"
}

show_help() {
    printf "${BOLD}Available MaxRegnerOS Mobile Commands:${RESET}\n"
    printf "  ${GREEN}sysinfo${RESET}    - Show detailed mobile system architecture & RAM breakdown\n"
    printf "  ${GREEN}devstat${RESET}    - Display Motorola Moto G22 hardware diagnostics\n"
    printf "  ${GREEN}gui${RESET}        - Launch MaxRegnerOS Mobile Touch Screen Desktop UI Framework\n"
    printf "  ${GREEN}maxpack${RESET}    - Launch MaxRegnerOS Mobile Package Manager\n"
    printf "  ${GREEN}thermal${RESET}    - Read MT6765 SoC thermal sensors\n"
    printf "  ${GREEN}boost${RESET}      - Activate CyberBoost ultra performance mode\n"
    printf "  ${GREEN}eco${RESET}        - Activate battery saver eco mode\n"
    printf "  ${GREEN}matrix${RESET}     - Stream Cyberpunk Digital Matrix display\n"
    printf "  ${GREEN}features${RESET}   - Show unique MaxRegnerOS Mobile features\n"
    printf "  ${GREEN}theme${RESET}      - Change terminal color theme (cyan/green/purple/red)\n"
    printf "  ${GREEN}clear${RESET}      - Clear the screen & display banner\n"
    printf "  ${GREEN}exit${RESET}       - Exit MaxRegnerOS Mobile shell\n"
    printf "\n"
}

show_sysinfo() {
    printf "${CYAN}${BOLD}[MaxRegnerOS Mobile System Architecture]${RESET}\n"
    printf " OS Name:       MaxRegnerOS Mobile Linux\n"
    printf " Version:       1.0-ULTRA Cyberhawaii\n"
    printf " Device:        Motorola Moto G22 (hawaiipl)\n"
    printf " Chipset:       MediaTek MT6765 / Helio G37 (ARM64)\n"
    printf " CPU Cores:     8x ARM Cortex-A53\n"
    printf " Hostname:      $(hostname 2>/dev/null || echo 'maxregneros')\n"
    printf " Kernel:        Stock Motorola Moto G22 Kernel (Linux 4.19.191)\n"
    printf " Memory (RAM):  $(free -h 2>/dev/null | awk '/Mem:/ {print $2}' || echo '4.0 GB LPDDR4X')\n"
    printf " Storage:       UserData Partition Direct Mount (/data)\n"
    printf "\n"
}

show_features() {
    printf "${PURPLE}${BOLD}[MaxRegnerOS Mobile Key Features]${RESET}\n"
    printf " 1. ${BOLD}Zero-Kernel Modification Direct Boot:${RESET} Boots full Linux OS directly from /userdata with stock kernel.\n"
    printf " 2. ${BOLD}MaxGUI Mobile Desktop Framework:${RESET} Touch-friendly mobile Linux window/desktop server interface.\n"
    printf " 3. ${BOLD}MaxPack Package Manager:${RESET} Mobile package installer for ARM64 Linux tools & apps.\n"
    printf " 4. ${BOLD}CyberBoost Engine:${RESET} Locks all 8 Cortex-A53 CPU cores to max clock for heavy mobile multitasking.\n"
    printf " 5. ${BOLD}Hardware Diagnostic Monitor:${RESET} Real-time MT6765 thermal, battery, and governor metrics.\n"
    printf "\n"
}

run_matrix() {
    printf "${GREEN}"
    printf "Streaming Cyber Matrix... Press Ctrl+C to break.\n"
    i=0
    while [ $i -lt 25 ]; do
        printf "%s " "$(head -c 30 /dev/urandom 2>/dev/null | xxd -p 2>/dev/null || echo "101010101010101010101010101010")"
        i=$((i + 1))
        sleep 0.05
    done
    printf "${RESET}\n\n"
}

show_banner
printf "Type ${GREEN}'help'${RESET} to list available commands, or ${GREEN}'gui'${RESET} for Touch Desktop UI.\n\n"

while true; do
    printf "${CYAN}${BOLD}maxregneros@hawaiipl-mobile${RESET}:${YELLOW}~$ ${RESET}"
    read CMD
    case "$CMD" in
        help)
            show_help
            ;;
        sysinfo)
            show_sysinfo
            ;;
        gui)
            if [ -f /maxregneros/bin/maxgui ]; then
                /bin/sh /maxregneros/bin/maxgui
            elif [ -f maxregneros/bin/maxgui ]; then
                /bin/sh maxregneros/bin/maxgui
            else
                echo "MaxGUI Mobile Framework initializing..."
            fi
            ;;
        maxpack*)
            if [ -f /maxregneros/bin/maxpack ]; then
                /bin/sh /maxregneros/bin/maxpack $CMD
            elif [ -f maxregneros/bin/maxpack ]; then
                /bin/sh maxregneros/bin/maxpack $CMD
            else
                echo "MaxPack Package Manager ready."
            fi
            ;;
        devstat|thermal)
            if [ -f /maxregneros/maxregneros_control.sh ]; then
                /bin/sh /maxregneros/maxregneros_control.sh stats
            else
                show_sysinfo
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
            printf "${GREEN}Shutting down MaxRegnerOS Mobile Session. Goodbye!${RESET}\n"
            break
            ;;
        "")
            ;;
        *)
            printf "${RED}Command not found: $CMD. Type 'help' for available commands.${RESET}\n"
            ;;
    esac
done
