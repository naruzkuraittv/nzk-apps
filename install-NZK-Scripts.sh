#!/bin/bash
# Script to install "learn to install"

CONFIG_FILE="$HOME/.config/nzk-apps/settings.conf"

# Function to confirm user's input
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

# Function to ask if the user is NaruZKurai
areyounaruzkurai() {
    echo "Are you NaruZKurai? (y/n)"
    echo "If you aren't and you say yes, things will break."
    echo "So if you are you NaruZKurai, v1 will be installed and uses /home/kali as default user path"
    read -p "Please enter your answer: " answer
    answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')
    if [[ $answer == "yes" || $answer == "y" ]]; then
        isnaruzkurai="yes"
        echo "Cool, let's get started."
    elif [[ $answer == "no" || $answer == "n" ]]; then
        isnaruzkurai="no"
        echo "Cool, let's get started."
    else
        echo "Something went wrong. Please try again."
        areyounaruzkurai
    fi
}

# Ask if the user is NaruZKurai
areyounaruzkurai

# Check and copy the appropriate version of nzk-code
if [[ $isnaruzkurai == "yes" ]]; then
    if cp -f ./bash/app-nzk-code/nzk-code1 ./nzk-code; then
        echo "nzk-code1 copied successfully."
    else
        echo "Failed to copy nzk-code1. Ensure the file exists and try again."
        exit 1
    fi
elif [[ $isnaruzkurai == "no" ]]; then
    if cp -f ./bash/app-nzk-code/nzk-code3 ./nzk-code; then
        echo "nzk-code3 copied successfully."
    else
        echo "Failed to copy nzk-code3. Ensure the file exists and try again."
        exit 1
    fi
else
    echo "Something went wrong. Please try again."
    exit 69
fi

# Create config file and copy nzk scripts to /usr/local/bin
find ./bash/app-nzk/ -name 'nzk-*' -type f | while read -r script; do
    if sudo cp -f "$script" /usr/local/bin/; then
        sudo chmod +x "/usr/local/bin/$(basename "$script")"
        echo "$(basename "$script") copied and permissions set."
    else
        echo "Failed to copy $(basename "$script"). Ensure the file exists and try again."
        exit 1
    fi
done

echo "Installation complete."