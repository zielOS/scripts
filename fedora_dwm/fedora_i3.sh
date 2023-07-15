#!/bin/bash

echo "Setting up Repos"
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && sudo dnf install dnf-plugins-core && sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/ && sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

sudo dnf copr enable atim/alacritty
sudo dnf copr enable atim/lazygit
sudo dnf copr enable nonamedotc/xfce418

echo "Installing Several Packages"
sudo dnf install lxsession neovim akmod-nvidia papirus-icon-theme npm nodejs pipewire pipewire-alsa pipewire-pulseaudio pipewire-utils wireplumber alsa-utils thunar thunar-volman thunar-media-tags-plugin gvfs thunar-archive-plugin file-roller tumbler kvantum qt5ct neofetch zsh util-linux-user brave-browser sysstat psacct rng-tools cronie wget aide lynis mpv transmission-gtk copr-selinux zathura zathura-zsh-completion zathura-pdf-poppler acpi feh rofi dunst xclip xsel xfce4-power-manager picom emacs i3 sddm sxhkd xdg-desktop-portal-gtk flatpak

echo "Installing Dot files"
sudo rm -R ~/.config/
cd && mkdir ~/.config  
git clone https://gitlab.com/ahsanur041/mydots.git
ln -s $HOME/.dots/gtk-3.0/ ~/.config/
ln -s $HOME/.dots/wallpapers/ ~/.config/
ln -s $HOME/.dots/zathura/ ~/.config/
ln -s $HOME/.dots/rofi/ ~/.config/
ln -s $HOME/.dots/zsh/ ~/.config/
ln -s $HOME/.dots/.zshrc ~/
ln -s $HOME/.dots/.fonts/ ~/
ln -s $HOME/.dots/.themes/ ~/
ln -s $HOME/.dots/.gtkrc-2.0/ ~/
ln -s $HOME/.dots/.Xresources ~/
ln -s $HOME/.dots/picom ~/.config/
ln -s $HOME/.dots/dunst ~/.config/
ln -s $HOME/.dots/eww ~/.config/
ln -s $HOME/.dots/i3 ~/.config/
ln -s $HOME/.dots/sxhkd ~/.config/
ln -s $HOME/.dots/alacritty ~/.config/

echo "Setting Up Systemd"
cd 
sudo systemctl set-default graphical.target 
systemctl --user enable --now wireplumber.service pipewire-pulse.socket pipewire.socket pipewire-pulse.service pipewire.service pipewire-pulse.socket pipewire.socket pipewire-pulse.service pipewire.service

echo "Setting Up npm"
cd 
mkdir ~/.npm-global 
npm config set prefix '~/.npm-global' 

echo "Setting Up zsh shell"
curl -fsSL https://fnm.vercel.app/install | sh
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh)
chsh -s $(which zsh)

echo "Setting up Scripts"
cd 
cd scripts/fedora_i3
sudo install -Dm755 i3start "/usr/local/bin/i3start"
sudo install -Dm755 i3volume "/usr/local/bin/i3volume"
sudo install -Dm755 i3monitor "/usr/local/bin/i3monitor"
sudo install -Dm755 i3menu "/usr/local/bin/i3menu"
sudo install -Dm755 eww "/usr/local/bin/eww"

echo "Setting up text editors"
git clone https://gitlab.com/ahsanur041/neovim ~/.config/nvim
git clone https://gitlab.com/ahsanur041/emacs ~/.emacs.d/
