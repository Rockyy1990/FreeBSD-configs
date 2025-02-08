#!/bin/sh

# Last Edit: 06.02.2025

echo ""
echo "-------------------------------------"
echo "       Install Cinnamon Desktop      "
echo "				 FreeBSD			   "
echo "-------------------------------------"
echo ""
echo " This script must start with root privileges"
sleep 2

echo ""
read -p " Read this script before execute!!. Press any key to continue.."
clear

# Update the package repository
pkg update

# Install Xorg server and necessary components
pkg install -y sudo nano fakeroot xorg xorg-server xorg-drivers xorg-fonts xorg-xinit

# Install Cinnamon desktop environment
pkg install -y cinnamon

# Install LightDM display manager
pkg install -y lightdm lightdm-gtk-greeter

# Install D-Bus and ConsoleKit for session management
pkg install -y dbus consolekit

# Install Mesa for OpenGL support
pkg install -y mesa-libs mesa-dri

# Install Vulkan support
pkg install -y vulkan-icd-loader vulkan-tools

# Install Wine for running Windows applications
pkg install -y wine64 winetricks libfaudio

# Install additional gaming packages for Wine
pkg install -y wine64-devel wine-staging winetricks

# Install AMD GPU drivers
pkg install -y drm-kmod

# Load the AMD kernel module
kldload amdgpu

# Install multimedia support
pkg install -y gstreamer1 gstreamer1-plugins-base gstreamer1-plugins-good gstreamer1-plugins-bad gstreamer1-plugins-ugly
pkg install -y soundconverter vlc lame flac libavcodec libavformat libx264 x264 pavucontrol pavucontrol

# Install additional applications
pkg install -y firefox thunderbird libreoffice transmission-gtk mousepad


# Define the line to be added
FSTAB_LINE="proc    /proc    procfs    rw    0    0"

# Check if the line already exists in /etc/fstab
if ! grep -q "$FSTAB_LINE" /etc/fstab; then
    # Append the line to /etc/fstab
    echo "$FSTAB_LINE" >> /etc/fstab
    echo "Added the following line to /etc/fstab:"
    echo "$FSTAB_LINE"
else
    echo "The line already exists in /etc/fstab."
fi


# Enable necessary services
sysrc lightdm_enable="YES"
sysrc dbus_enable="YES"
sysrc hald_enable="YES"
sysrc snd_hda_load="YES"
sysrc consolekit_enable="YES"
sysrc linux_enable="YES"

# Optimize system settings
# Enable hardware acceleration for video playback
echo "hw.acceleration=1" >> /etc/sysctl.conf



# Inform the user to start the X server
clear
echo "Installation complete."
sleep 3

# Reboot the system to load the new kernel module and LightDM
clear
sleep 3
echo "Rebooting the system to apply changes..."
reboot