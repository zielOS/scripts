#!/bin/bash

#---- Prepare AUR ---------------------------------
#---- Setup Hyprland Functionality ----------------

cd && cd AUR && git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si -r && cd

yay -S fnm eww papirus-icon-theme papirus-folders-catppuccin-git catppuccin-gtk-theme-mocha catppuccin-cursors-mocha ckb-next aide insync acct

#-------------------------------------------------
#---- SETUP OTHER APPS----------------------------
#-------------------------------------------------

sudo systemctl set-default graphical.target 
systemctl --user enable --now wireplumber.service pipewire-pulse.socket pipewire.socket pipewire-pulse.service pipewire.service pipewire-pulse.socket pipewire.socket pipewire-pulse.service pipewire.service
echo "Setting Up npm"
cd 
mkdir ~/.npm-global 
npm config set prefix '~/.npm-global' 

echo "Setting Up zsh shell"
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh)
chsh -s $(which zsh)


