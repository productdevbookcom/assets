#!/bin/bash

# Update and Upgrade
echo "Update and Upgrade"

sudo apt update
sudo apt upgrade -y
sudo apt autoremove
sudo apt autoclean

# Install Wget

if [ -x "$(command -v wget)" ]
then
    echo "Wget is already installed"
else
    echo "Installing Wget"

    sudo apt update
    sudo apt install wget

    exec bash
fi

# Install curl

if [ -x "$(command -v curl)" ]
then
    echo "Curl is already installed"
else
    echo "Installing Curl"

    sudo apt update
    sudo apt install curl
    
    exec bash
fi

# Install Git

if [ -x "$(command -v git)" ]
then
    echo "Git is already installed"
else
    echo "Installing Git"

    sudo apt update
    sudo apt install git

    exec bash
fi


# Install snap

if [ -x "$(command -v snap)" ]
then
    echo "Snap is already installed"
else
    echo "Installing Snap"

    sudo apt update
    sudo apt install snapd

    exec bash
fi

# Install Visual Studio Code

if [ -x "$(command -v code)" ]
then
    echo "Visual Studio Code is already installed"
else
    echo "Installing Visual Studio Code"

    sudo snap install code --classic

    exec bash
fi

# Install Google Chrome

if [ -x "$(command -v google-chrome)" ] 
then
    echo "Google Chrome is already installed"
else
    echo "Installing Google Chrome"

    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
    
    sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

    sudo apt update
    sudo apt install google-chrome-stable

    exec bash
fi

# Install Node.js

if [ -x "$(command -v node)" ]
then
    echo "Node.js is already installed"
else
    echo "Installing Node.js"
    
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    sudo apt-get install -y nodejs
    node -v

    exec bash
fi

# Install Pnpm

if [ -x "$(command -v pnpm)" ]
then
    echo "Pnpm is already installed"
else
    echo "Installing Pnpm"

    curl -fsSL https://get.pnpm.io/install.sh | sh -
    pnpm -v

    echo "Add Pnpm to PATH"
    # Add pnpm store to PATH
    echo 'export PATH="$PATH:~/.local/share/pnpm"' >> ~/.bashrc

    # export PATH="$PATH:~/.local/share/pnpm"
    echo 'export PATH="$PNPM_HOME:$PATH"' >> ~/.bashrc

    exec bash
fi

# Install Htop

if [ -x "$(command -v htop)" ]
then
    echo "Htop is already installed"
else
    echo "Installing Htop"

    sudo apt update
    sudo snap install htop
    
    exec bash
fi

# Android Studio

if [ -x "$(command -v android-studio)" ]
then
    echo "Android Studio is already installed"
else
    echo "Installing Android Studio"

    sudo snap install android-studio --classic

    echo "Add Android Studio to PATH"

    # Add Android Studio to PATH
    echo 'export ANDROID_HOME=$HOME/Android/Sdk' >> ~/.bashrc
    echo 'export ANDROID_SDK_ROOT=$HOME/Android/Sdk' >> ~/.bashrc
    echo 'export PATH=$PATH:$ANDROID_HOME/emulator' >> ~/.bashrc
    echo 'export PATH=$PATH:$ANDROID_HOME/tools' >> ~/.bashrc
    echo 'export PATH=$PATH:$ANDROID_HOME/tools/bin' >> ~/.bashrc
    echo 'export PATH=$PATH:$ANDROID_HOME/platform-tools' >> ~/.bashrc

    echo 'export ANDROID_USER_HOME=$HOME/.android' >> ~/.bashrc
    echo 'export ANDROID_EMULATOR_HOME=$HOME/.android' >> ~/.bashrc
    echo 'export ANDROID_AVD_HOME=$HOME/.android/avd' >> ~/.bashrc

    exec bash
fi


# Install Starship

if [ -x "$(command -v starship)" ]
then
    echo "Starship is already installed"
else
    echo "Installing Starship"

    sudo snap install starship

    # Add Starship to PATH
    echo "Add Starship to PATH"

    echo 'eval "$(starship init bash)"' >> ~/.bashrc

    exec bash
fi

# Install Beekeeper Studio

if [ -x "$(command -v beekeeper-studio)" ]
then
    echo "Beekeeper Studio is already installed"
else
    echo "Installing Beekeeper Studio"

    sudo snap install beekeeper-studio

    exec bash
fi


# Install Bun

if [ -x "$(command -v bun)" ]
then
    echo "Bun is already installed"
else
    echo "Installing Bun"

    curl -fsSL https://bun.sh/install | bash

    exec bash
fi

# Brew

if [ -x "$(command -v brew)" ]
then
    echo "Brew is already installed"
else
    echo "Installing Brew"

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Brew to PATH
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc

    exec bash
fi

# Ruby

if [ -x "$(command -v ruby)" ]
then
    echo "Ruby is already installed"
else
    echo "Installing Ruby"

    brew install rbenv ruby-build

    # Add Ruby to PATH

    echo 'eval "$(rbenv init - bash)"' >> ~/.bashrc

    exec bash
fi

# Fastlane

if [ -x "$(command -v fastlane)" ]
then
    echo "Fastlane is already installed"
else
    echo "Installing Fastlane"

    brew install fastlane
    
    exec bash
fi


# Install Docker Desktop

if [ -x "$(command -v docker)" ]
then
    echo "Docker Desktop is already installed"
else
    # KVM/QEMU
    sudo apt-get update
    
    sudo apt-get install -y \
              bridge-utils \
              cpu-checker \
              libvirt-clients \
              libvirt-daemon \
              qemu qemu-kvm \
              virt-manager

    sudo kvm-ok

    sudo apt-get update

    sudo apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        lsb-release

    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.lis

    echo "Installing Docker Desktop"
    curl -fsSL -o /tmp/docker-desktop-amd64.deb https://desktop.docker.com/linux/main/amd64/docker-desktop-4.16.2-amd64.deb
    
    sudo apt-get install -y /tmp/docker-desktop-amd64.deb
    rm -f /tmp/docker-desktop-amd64.deb

    sudo apt-get update

    # Validate current $USER is enabled for docker group
    if ! (groups | grep docke); then
      echo "Add $USER to docker group by running the following:"
      echo "----"
      echo ""
      echo "sudo usermod -aG docker $USER"
      echo "newgrp docker"
    fi


fi
