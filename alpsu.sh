#!/bin/bash
echo " 
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⡀⠒⠒⠦⣄⡀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢀⣤⣶⡾⠿⠿⠿⠿⣿⣿⣶⣦⣄⠙⠷⣤⡀⠀⠀⠀⠀
⠀⠀⠀⣠⡾⠛⠉⠀⠀⠀⠀⠀⠀⠀⠈⠙⠻⣿⣷⣄⠘⢿⡄⠀⠀⠀
⠀⢀⡾⠋⠀⠀⠀⠀⠀⠀⠀⠀⠐⠂⠠⢄⡀⠈⢿⣿⣧⠈⢿⡄⠀⠀
⢀⠏⠀⠀⠀⢀⠄⣀⣴⣾⠿⠛⠛⠛⠷⣦⡙⢦⠀⢻⣿⡆⠘⡇⠀⠀
⠀⠀⠀⠀⡐⢁⣴⡿⠋⢀⠠⣠⠤⠒⠲⡜⣧⢸⠄⢸⣿⡇⠀⡇⠀⠀
⠀⠀⠀⡼⠀⣾⡿⠁⣠⢃⡞⢁⢔⣆⠔⣰⠏⡼⠀⣸⣿⠃⢸⠃⠀⠀    https://github.com/Alp19
⠀⠀⢰⡇⢸⣿⡇⠀⡇⢸⡇⣇⣀⣠⠔⠫⠊⠀⣰⣿⠏⡠⠃⠀⠀⢀
⠀⠀⢸⡇⠸⣿⣷⠀⢳⡈⢿⣦⣀⣀⣀⣠⣴⣾⠟⠁⠀⠀⠀⠀⢀⡎
⠀⠀⠘⣷⠀⢻⣿⣧⠀⠙⠢⠌⢉⣛⠛⠋⠉⠀⠀⠀⠀⠀⠀⣠⠎⠀
⠀⠀⠀⠹⣧⡀⠻⣿⣷⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⡾⠃⠀⠀
⠀⠀⠀⠀⠈⠻⣤⡈⠻⢿⣿⣷⣦⣤⣤⣤⣤⣤⣴⡾⠛⠉⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠈⠙⠶⢤⣈⣉⠛⠛⠛⠛⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
"
echo "                 ALP SYSTEM UPDATER  "
echo "--------------------------------------------------------------"

os_type=$(uname -s)

# Check for updates on macOS, Linux, and BSD
if [[ "$os_type" == "Darwin" ]]; then
    echo "MacOS operating system detected."
    echo "Checking system load..."

    softwareupdate -l | grep -q "No new software available."
    if [[ $? -eq 0 ]]; then
        echo "No update found."
    else
        echo "Updates found."
        read -p "Do you want to start the update? (Y/N): " answer
        if [[ "$answer" == "Y" || "$answer" == "y" ]]; then
            sudo softwareupdate -i -a
            echo "System update completed."
        else
            echo "The system update process has been cancelled."
        fi
    fi

elif [[ "$os_type" == "Linux" ]]; then
    echo "Linux operating system detected."
    echo "Checking for system updates..."

    # Detect package manager
    if command -v apt-get &>/dev/null; then
        # For Debian-based distributions
        updates=$(apt-get -s upgrade | grep -c ^Inst)
    elif command -v dnf &>/dev/null; then
        # For Fedora-based distributions
        updates=$(dnf list updates | grep -c "^")
    elif command -v yum &>/dev/null; then
        # For CentOS/RHEL-based distributions
        updates=$(yum check-update -q | grep -c "^")
    elif command -v zypper &>/dev/null; then
        # For openSUSE-based distributions
        updates=$(zypper list-patches | grep -c "^")
    elif command -v apk &>/dev/null; then
        # For Alpine-based distributions
        updates=$(apk upgrade --dry-run | grep -c "^")
    else
        echo "Unsupported package manager detected."
        exit 1
    fi

    if [[ $updates -eq 0 ]]; then
        echo "No update found."
    else
        echo "Updates found."
        read -p "Do you want to start the update? (Y/N): " answer
        if [[ "$answer" == "Y" || "$answer" == "y" ]]; then
            if command -v apt-get &>/dev/null; then
                sudo apt-get update
                sudo apt-get upgrade -y
            elif command -v dnf &>/dev/null; then
                sudo dnf upgrade -y
            elif command -v yum &>/dev/null; then
                sudo yum upgrade -y
            elif command -v zypper &>/dev/null; then
                sudo zypper refresh
                sudo zypper update -y
            elif command -v apk &>/dev/null; then
                sudo apk update
                sudo apk upgrade
            fi
            echo "System update completed."
        else
            echo "The system update process has been cancelled."
        fi
    fi

elif [[ "$os_type" == "FreeBSD" || "$os_type" == "OpenBSD" || "$os_type" == "NetBSD" ]]; then
    echo "BSD operating system detected."
    echo "Checking for system updates..."

    freebsd-update fetch install > /dev/null 2>&1
    if [[ $? -eq 0 ]]; then
        echo "Updates found."
        read -p "Do you want to start the update? (Y/N): " answer
        if [[ "$answer" == "Y" || "$answer" == "y" ]]; then
            sudo freebsd-update install
            echo "System update completed."
        else
            echo "The system update process has been cancelled."
        fi
    else
        echo "No updates found."
    fi

else
    echo "Unsupported operating system detected."
    exit 1
fi

echo "--------------------------------------------------------------"
echo "Thanks for using ALP System Updater!"
echo ""

