#!/bin/bash

sudo systemctl set-default graphical.target 
systemctl --user enable --now wireplumber.service pipewire-pulse.socket pipewire.socket pipewire-pulse.service pipewire.service pipewire-pulse.socket pipewire.socket pipewire-pulse.service pipewire.service emacs-28

echo "Setting Up Dotfiles"
ln -s $HOME/.dots/gtk-3.0/ ~/.config/
ln -s $HOME/.dots/lazygit/ ~/.config/
ln -s $HOME/.dots/wallpapers/ ~/.config/
ln -s $HOME/.dots/zathura/ ~/.config/
ln -s $HOME/.dots/rofi/ ~/.config/
ln -s $HOME/.dots/.fonts/ ~/
ln -s $HOME/.dots/.themes/ ~/
ln -s $HOME/.dots/.gtkrc-2.0/ ~/
ln -s $HOME/.dots/.Xresources ~/
ln -s $HOME/.dots/picom ~/.config/
ln -s $HOME/.dots/dunst ~/.config/
ln -s $HOME/.dots/eww ~/.config/

echo "Setting Up npm"
cd && mkdir ~/.npm-global 
npm config set prefix '~/.npm-global' 

echo "Setting Up Lunarvim"
LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
sudo rm -R $HOME/.config/lvim
ln -s $HOME/.dots/lvim $HOME/.config/

echo "Setting Up zsh shell"
curl -fsSL https://fnm.vercel.app/install | bash
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh)
chsh -s $(which zsh)
sudo rm -R $HOME/.zshrc
ln -s $HOME/.dots/zsh $HOME/.config/
ln -s $HOME/.dots/.zshrc $HOME/

echo "Setting Up tmux"
mkdir -p $HOME/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
tmux source $HOME/.tmux.conf
