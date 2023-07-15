#!/bin/bash

sudo systemctl set-default graphical.target 
systemctl --user enable --now wireplumber.service pipewire-pulse.socket pipewire.socket pipewire-pulse.service pipewire.service pipewire-pulse.socket pipewire.socket pipewire-pulse.service pipewire.service

echo "Setting Up Dotfiles"
cd && git clone https://gitlab.com/ahsanur041/mydots.git ~/.dots
rm -R .zshrc
ln -s $HOME/.dots/gtk-3.0/ ~/.config/
ln -s $HOME/.dots/lazygit/ ~/.config/
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
ln -s $HOME/.dots/sxhkd ~/.config/
ln -s $HOME/.dots/bspwm ~/.config/

echo "Setting Up npm"
cd 
mkdir ~/.npm-global 
npm config set prefix '~/.npm-global' 

echo "Setting Up zsh shell"
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh)
chsh -s $(which zsh)

cd scripts/gentoo_dwm
sudo install -Dm755 dwmstart "/usr/local/bin/dwmstart"
sudo install -Dm755 dwmmenu "/usr/local/bin/dwmmenu" 
sudo install -Dm644 dwm.desktop "/usr/share/xsessions/dwm.desktop"
sudo install -Dm755 dwmvolume "/usr/local/bin/dwmvolume"
sudo install eww "/usr/local/bin/eww" 
