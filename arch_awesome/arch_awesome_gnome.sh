#!/bin/bash

#------------------------------------------------------------------
#---- SETUP AWESOEM & DE -----------------------------------------
#------------------------------------------------------------------

#---- Prepare AUR ---------------------------------
echo "Prepare AUR"
cd && mkdir AUR

#---- Setup Hyprland Functionality ----------------

cd && cd AUR && git clone http:ws://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si -r && cd

#---- Setup Hyprland Theme ------------------------

yay -Syu awesome-luajit-git luarocks aide papirus-icon-theme papirus-folders-catppuccin-git catppuccin-gtk-theme-mocha catppuccin-cursors-mocha ckb-next insync picom-ftlabs-git brave-bin kitty rofi acpi acpid acpi_call upower lxappearance-gtk3 unzip zip unrar btrfs-progs dosfstools wget curl neofetch upower zathura zathura-pdf-poppler python-pynvim neovim ripgrep fd zsh zsh-completions zoxide fzf fuse flatpak lazygit xdg-user-dirs xdg-user-dirs-gtk xdg-utils gvfs feh rofi flameshot xsel xclip xorg nvidia nvidia-utils nvidia-settings mesa rng-tools haveged lynis firejail audit sysstat apparmor snapper snap-pac-grub mlocate fdupestmux keepassxc tldr linux linux-headers snapd pipewire pipewire-alsa pipewire-pulse alsa-utils fnm 

yay -Syu  wezterm rofi acpi acpid acpi_call upower lxappearance-gtk3 jq inotify-tools polkit-gnome xdotool xclip gpick ffmpeg blueman redshift pipewire pipewire-alsa pipewire-pulse alsa-utils brightnessctl feh maim mpv mpd mpc mpdris2 python-mutagen ncmpcpp playerctl

sudo systemctl set-default graphical.target 
systemctl --user enable --now wireplumber.service pipewire-pulse.socket pipewire.socket pipewire-pulse.service pipewire.service pipewire-pulse.socket pipewire.socket pipewire-pulse.service pipewire.service

echo "Installing Yoru"
cd && mkdir $HOME/.fonts
git clone --depth 1 --recurse-submodules https://github.com/rxyhn/yoru.git
cd yoru && git submodule update --remote --merge
cp -r config/* $HOME/.config/
cp -r misc/fonts/* $HOME/.fonts/


echo "Setting Up npm"
cd 
mkdir ~/.npm-global 
npm config set prefix '~/.npm-global' 

echo "Setting Up zsh shell"
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh)
chsh -s $(which zsh)


