#!/bin/bash

CONFIG_FILE="$HOME/.config/nzk-apps/settings.conf"
isnaruzkurai=""

areyousure() {
    read -p "Are you sure? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        answer="yes"
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        answer="no"
    else
        echo "Invalid input. Please enter y or n."
        areyousure
    fi
}

areyounaruzkurai() {
    echo "Are you NaruZKurai? (y/n)"
    echo "If you aren't and you say yes, things will break."
    echo "So if you are you NaruZKurai, v1 will be installed and uses /home/kali as default user path"
    read -p "Please enter your answer: " isnzkanswer
    nzkanswer=$(echo "$isnzkanswer" | tr '[:upper:]' '[:lower:]')
    if [[ $nzkanswer == "yes" || $nzkanswer == "y" ]]; then
        isnaruzkurai="yes"
        echo "Cool, let's get started."
    elif [[ $nzkanswer == "no" || $nzkanswer == "n" ]]; then
        isnaruzkurai="no"
        echo "Cool, let's get started."
    else
        echo "Invalid input"
        areyounaruzkurai
    fi
}

areyounaruzkurai

skipnzkcodeq() {
    echo "Since it failed...."
    read -p "Do you want to skip installing nzk-code? (y/n): " skipcodeinstall
    skipcodeinstall=$(echo "$skipcodeinstall" | tr '[:upper:]' '[:lower:]')
    if [[ $skipcodeinstall == "yes" || $skipcodeinstall == "y" ]]; then
        echo "Cool, skipping."
    elif [[ $skipcodeinstall == "no" || $skipcodeinstall == "n" ]]; then
        echo "Cool, skipping."
    else
        echo "Invalid input"
        skipnzkcodeq
    fi
}

exitq() {
    echo "TOO BAD"
    echo "We either skip it or exit"
    read -p "So we continuing? (y/n): " answer
    answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')
    if [[ $answer == "yes" || $answer == "y" ]]; then
        echo "Cool, skipping."
    elif [[ $answer == "no" || $answer == "n" ]]; then
        echo "Cool, exiting"
        exit 1
    else
        echo "Invalid input"
        exitq
    fi
}

if [[ $isnaruzkurai == "yes" ]]; then
    if cp -f ./bash/app-nzk-code/nzk-code1 ./bash/nzk-code; then
        echo "nzk-code1 copied successfully."
    else
        echo "Failed to copy nzk-code1. Does it exist?"
        skipnzkcodeq 
    fi
elif [[ $isnaruzkurai == "no" ]]; then 
    if cp -f ./bash/app-nzk-code/nzk-code3 ./bash/nzk-code; then
        echo "nzk-code3 copied successfully."
    else
        echo "Failed to copy nzk-code3. Does it exist?"
        skipnzkcodeq 
    fi
else
    echo "Something went wrong. Please try again."
    exit 1
fi

# Create config file and copy nzk scripts to /usr/local/bin and /bin respectively
find ./bash -name 'nzk-*' -type f | while read -r script; do
    if sudo cp -f "$script" /bin/; then
        sudo chmod +x "/bin/$(basename "$script")"
        echo "$(basename "$script") copied and permissions set."
    else
        echo "Failed to copy $(basename "$script")."
        exit 1
    fi
done

# Ensure the directory exists before touching the config file
mkdir -p "$(dirname "$CONFIG_FILE")"
sudo touch "$CONFIG_FILE"

echo "Installation complete."
