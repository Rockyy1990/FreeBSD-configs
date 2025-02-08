#!/bin/sh

# Last Edit: 06.02.2025

echo ""
echo "-------------------------------------"
echo "         Install XFCE Desktop        "
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
pkg install -y sudo nano fakeroot fontconfig xorg xorg-server xorg-drivers xorg-fonts xorg-xinit

# Install XFCE desktop environment
pkg install -y xfce xfce4-goodies 

# Install LightDM display manager
pkg install -y lightdm lightdm-gtk-greeter

# Install D-Bus and ConsoleKit for session management
pkg install -y dbus consolekit

# Install Mesa for OpenGL support
pkg install -y mesa-libs mesa-dri

# Install Vulkan support
pkg install -y vulkan-icd-loader vulkan-tools

# Install Wine for running Windows applications
pkg install -y wine64 winetricks wine-mono wine-gecko libfaudio cabextract


# Install AMD GPU drivers
pkg install -y drm-kmod

# Load the AMD kernel module
kldload amdgpu

# Install multimedia support
pkg install -y gstreamer1 gstreamer1-plugins-base gstreamer1-plugins-good gstreamer1-plugins-bad gstreamer1-plugins-ugly gstreamer1-ffmpeg
pkg install -y soundconverter vlc lame flac libavcodec libavformat libx264 x264 pavucontrol

# Install additional applications
pkg install -y firefox thunderbird libreoffice transmission-gtk mousepad file-roller

# Enable the XFCE session manager
echo "exec startxfce4" >> ~/.xinitrc

# Configure LightDM to use XFCE
echo "[Seat:*]" > /usr/local/etc/lightdm/lightdm.conf
echo "autologin-user=$USER" >> /usr/local/etc/lightdm/lightdm.conf
echo "session-setup-script=/usr/local/bin/xfce4-session" >> /usr/local/etc/lightdm/lightdm.conf

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


# Clean up
pkg clean


# Inform the user to start the X server
clear
echo "Installation complete. You can start the XFCE desktop environment by running 'startx' or reboot to use LightDM."
sleep 3

# Reboot the system to load the new kernel module and LightDM
clear
sleep 3
echo "Rebooting the system to apply changes..."
reboot