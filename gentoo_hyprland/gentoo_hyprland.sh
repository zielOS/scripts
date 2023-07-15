#!/bin/bash

echo "Installing Dot files"
sudo rm -R ~/.config/
cd && mkdir ~/.config  
git clone https://github.com/Ahsan041/workstation-dots ~/.dots
ln -s $HOME/.dots/.fonts $HOME/
ln -s $HOME/.dots/.themes $HOME/
ln -s $HOME/.dots/ckb-next $HOME/.config/ 
ln -s $HOME/.dots/emacs $HOME/
ln -s $HOME/.dots/eww $HOME/.config/
ln -s $HOME/.dots/gammastep $HOME/.config/
ln -s $HOME/.dots/gtk-3.0 $HOME/.config/
ln -s $HOME/.dots/hypr  $HOME/.config/
ln -s $HOME/.dots/kitty $HOME/.config/
ln -s $HOME/.dots/lazygit $HOME/.config/
ln -s $HOME/.dots/swhkd $HOME/.config/
ln -s $HOME/.dots/Thunar $HOME/.config/
ln -s $HOME/.dots/TODOS $HOME/
ln -s $HOME/.dots/waybar $HOME/.config/
ln -s $HOME/.dots/wlogout $HOME/.config/
ln -s $HOME/.dots/wofi $HOME/.config/
ln -s $HOME/.dots/zsh $HOME/.config/
ln -s $HOME/.dots/.gtkrc-2.0 $HOME/
ln -s $HOME/.dots/.zshrc $HOME/
ln -s $HOME/.dots/colorscheme.css $HOME/
ln -s $HOME/.dots/electron-flags.conf $HOME/.config/
ln -s $HOME/.dots/electron13-flags.conf $HOME/.config/

echo "Setup flatpak"
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install com.github.tchx84.Flatseal
flatpak install flathub org.mozilla.firefox

echo "Setting up Scripts"
cd && cd scripts/gentoo_hyprland/scripts
sudo install -Dm755 hyprland-nvidia "/usr/local/bin/hyprland-nvidia"
sudo install -Dm755 hyprbar "/usr/local/bin/hyprbar"
sudo install -Dm755 hyprgamma "/usr/local/bin/hyprgamma"
sudo install -Dm755 hypridle "/usr/local/bin/hypridle"
sudo install -Dm755 hyprkeys "/usr/local/bin/hyprkeys"
sudo install -Dm755 hyprlock "/usr/local/bin/hyprlock"
sudo install -Dm755 hyprlogout "/usr/local/bin/hyprlogout"
sudo install -Dm755 hyprmenu "/usr/local/bin/hyprmenu"
sudo install -Dm755 hyprpolkit "/usr/local/bin/hyprpolkit"
sudo install -Dm755 hyprshot "/usr/local/bin/hyprshot"
sudo install -Dm755 hyprsome "/usr/local/bin/hyprsome"
sudo install -Dm755 hyprstart "/usr/local/bin/hyprstart"
sudo install -Dm755 hyprterm "/usr/local/bin/hyprterm"
sudo install -Dm755 hyprtheme "/usr/local/bin/hyprtheme"
sudo install -Dm755 hyprwall "/usr/local/bin/hyprwall"

git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim

echo "Setting Up Systemd"
sudo systemctl set-default graphical.target 
systemctl --user enable --now wireplumber.service pipewire-pulse.socket pipewire.socket pipewire-pulse.service pipewire.service pipewire-pulse.socket pipewire.socket pipewire-pulse.service pipewire.service

cd && mkdir ~/.npm-global && npm config set prefix '~/.npm-global' 

zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh)
