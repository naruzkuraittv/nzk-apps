#!/bin/bash
# Script to install "learn to install"

CONFIG_FILE="~/.config/nzk-apps/settings.conf"

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
    echo "So... are you NaruZKurai? aka do you wanna use your laptop v.01 code?"
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
    cp ./shell/app-nzk-code/nzk-code1 ./nzk-code
elif [[ $isnaruzkurai == "no" ]]; then
    cp ./shell/app-nzk-code/nzk-code3 ./nzk-code
else
    echo "Something went wrong. Please try again."
    exit 69
fi

# Create config file and copy nzk scripts to /usr/local/bin
cp ./shell/app-nzk/nzk-* /usr/local/bin/
chmod +x /usr/local/bin/nzk-*

echo "Installation complete."
