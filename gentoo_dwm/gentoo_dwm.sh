#!/bin/bash

sudo systemctl set-default graphical.target && sudo systemctl enable lightdm
systemctl --user enable --now wireplumber.service pipewire-pulse.socket pipewire.socket pipewire-pulse.service pipewire.service pipewire-pulse.socket pipewire.socket pipewire-pulse.service pipewire.service emacs-28

echo "Setting Up Dotfiles"
cd && rm -R .zshrc
ln -s $HOME/.dots/gtk-3.0/ ~/.config/
ln -s $HOME/.dots/lazygit/ ~/.config/
ln -s $HOME/.dots/wallpapers/ ~/.config/
ln -s $HOME/.dots/zathura/ ~/.config/
ln -s $HOME/.dots/zsh/ ~/.config/
ln -s $HOME/.dots/.zshrc ~/
ln -s $HOME/.dots/.themes/ ~/
ln -s $HOME/.dots/.gtkrc-2.0/ ~/
ln -s $HOME/.dots/.Xresources ~/
ln -s $HOME/.dots/picom ~/.config/
ln -s $HOME/.dots/sxhkd ~/.config/
ln -s $HOME/.dots/suckless ~/.config/
ln -s $HOME/.dots/dunst ~/.config/
ln -s $HOME/.dots/jgmenu ~/.config/
ln -s $HOME/.dots/lsd ~/.config/
ln -s $HOME/.dots/eww ~/.config/

echo "Setting Up npm"
cd 
mkdir ~/.npm-global 
npm config set prefix '~/.npm-global' 

echo "Setting Up zsh shell"
curl -fsSL https://fnm.vercel.app/install | bash
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh)
chsh -s $(which zsh)
