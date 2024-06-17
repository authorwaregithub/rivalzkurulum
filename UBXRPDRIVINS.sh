#!/bin/bash

# Define user and password variables

USER="rivalz"
PASSWORD="P789456123s"

# Update the package list
sudo apt update

# Install GNOME Desktop
sudo apt install -y ubuntu-desktop

# Install the remote desktop server (xrdp)
sudo apt install -y xrdp

# Add the user USER with the password
sudo useradd -m -s /bin/bash $USER
echo "$USER:$PASSWORD" | sudo chpasswd

# Add the user USER to the sudo group for administrative rights
sudo usermod -aG sudo $USER


# Restart the xrdp service
sudo systemctl restart xrdp

# Enable xrdp at startup
sudo systemctl enable xrdp

# Install the necessary dependencies for Rivalz.ai rClient
sudo apt install -y wget

# Download the Rivalz.ai rClient AppImage
wget https://api.rivalz.ai/fragmentz/clients/rClient-latest.AppImage -O rClient-latest.AppImage

# Make the AppImage executable
chmod +x rClient-latest.AppImage

# Create the Documents directory if it doesn't exist
sudo -u $USER mkdir -p /home/$USER/Documents

# Move the AppImage to the user's Documents directory
sudo mv rClient-latest.AppImage /home/$USER/Documents/rClient-latest.AppImage

# Change the owner of the rClient to the specified user
sudo chown $USER:$USER /home/$USER/Documents/rClient-latest.AppImage

echo "Kurulum Tamamlandı. Remote Desktop Kullarak Masaustu Arayuzune Baglanabilirsiniz. $USER $PASSWORD"