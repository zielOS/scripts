#!/bin/bash

echo "Setting up Repos"
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm 

sudo dnf copr enable atim/lazygit 
sudo dnf copr enable atim/alacritty
sudo dnf copr enable deathwish/emacs-pgtk-nativecomp 
sudo dnf update

echo "Installing Several Packages"
sudo dnf install alacritty emacs pixman polkit-devel xisxwayland xorg-x11-server-Xwayland xorg-x11-server-Xwayland-devel swaybg swayidle wofi wlogout swaylock grim slurp wf-recorder wl-clipboard mate-polkit pipewire pipewire-alsa pipewire-pulseaudio pipewire-utils wireplumber alsa-utils thunar thunar-volman thunar-media-tags-plugin thunar-archive-plugin file-roller  kvantum qt5ct neofetch zsh util-linux-user sysstat psacct rng-tools cronie wget aide lynis mpv transmission-gtk copr-selinux zathura zathura-zsh-completion zathura-pdf-poppler qt5-qtwayland acpi libva-devel akmod-nvidia nodejs npm papirus-icon-theme python3-devel gnome-keyring lazygit plymouth-theme-spinner ninja-build cmake meson gcc-c++ libxcb gtkmm3.0-devel alsa-utils yad ckb-next boom-boot && sudo plymouth-set-default-theme spinner -R

echo "Installing Dot files"
sudo rm -R ~/.config/
cd && mkdir ~/.config  
ln -s $HOME/.dots/alacritty/ ~/.config/
ln -s $HOME/.dots/gtk-3.0/ ~/.config/
ln -s $HOME/.dots/wofi/ ~/.config/
ln -s $HOME/.dots/dunst/ ~/.config/
ln -s $HOME/.dots/wallpapers/ ~/.config/
ln -s $HOME/.dots/wlogout/ ~/.config/
ln -s $HOME/.dots/zathura/ ~/.config/
ln -s $HOME/.dots/zsh/ ~/.config/
ln -s $HOME/.dots/.zshrc ~/
ln -s $HOME/.dots/hypr/ ~/.config/
ln -s $HOME/.dots/electron-flags.conf ~/.config/
ln -s $HOME/.dots/electron13-flags.conf ~/.config/
ln -s $HOME/.dots/.fonts/ ~/
ln -s $HOME/.dots/.themes/ ~/
ln -s $HOME/.dots/.gtkrc-2.0/ ~/
ln -s $HOME/.dots/dunst ~/.config/
ln -s $HOME/.dots/eww ~/.config/
ln -s $HOME/.dots/ckb-next/ ~/.config/
ln -s $HOME/.dots/Thunar/ ~/.config/
ln -s $HOME/.dots/.zprofile ~/

echo "Setting Up Systemd"
sudo systemctl set-default graphical.target 
systemctl --user enable --now wireplumber.service pipewire-pulse.socket pipewire.socket pipewire-pulse.service pipewire.service pipewire-pulse.socket pipewire.socket pipewire-pulse.service pipewire.service

cd && mkdir ~/.npm-global && npm config set prefix '~/.npm-global' 

curl -fsSL https://fnm.vercel.app/install | sh
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh)

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf install code

git clone https://gitlab.com/ahsanur041/neovim ~/.config/nvim
