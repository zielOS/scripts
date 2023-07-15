#!/bin/bash

echo "Installing Dot files"
cd 
sudo rm -R ~/.config/
rm -R .zshrc
mkdir ~/.config  
git clone https://gitlab.com/ahsanur041/mydots.git
ln -s $HOME/mydots/suckless/ ~/.config/
ln -s $HOME/mydots/gtk-3.0/ ~/.config/
ln -s $HOME/mydots/lazygit/ ~/.config/
ln -s $HOME/mydots/wallpapers/ ~/.config/
ln -s $HOME/mydots/zathura/ ~/.config/
ln -s $HOME/mydots/rofi/ ~/.config/
ln -s $HOME/mydots/zsh/ ~/.config/
ln -s $HOME/mydots/.zshrc ~/
ln -s $HOME/mydots/electron-flags.conf ~/.config/
ln -s $HOME/mydots/electron13-flags.conf ~/.config/
ln -s $HOME/mydots/.fonts/ ~/
ln -s $HOME/mydots/.themes/ ~/
ln -s $HOME/mydots/.gtkrc-2.0/ ~/
ln -s $HOME/mydots/.Xresources ~/
ln -s $HOME/mydots/picom ~/.config/
ln -s $HOME/mydots/dunst ~/.config/
ln -s $HOME/mydots/ckb-next ~/.config/

echo "Installing Brave"
cd
sudo apt update && sudo apt full-upgrade
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser

echo "Setting Up Systemd"
cd  
sudo systemctl set-default graphical.target 
systemctl --user enable --now wireplumber.service pipewire-pulse.socket pipewire.socket pipewire-pulse.service pipewire.service pipewire-pulse.socket pipewire.socket pipewire-pulse.service pipewire.service

echo "Setting up Scripts"
cd 
cd scripts/debian_dwm
sudo install -Dm755 run-dwmbar.sh "/usr/local/bin/run-dwmbar"
sudo install -Dm755 run-dwmautostart.sh "/usr/local/bin/run-dwm"
sudo install -Dm755 run-dwmapps.sh "/usr/local/bin/run-dwmapps" 
sudo install -Dm644 dwm.desktop "/usr/share/xsessions/dwm.desktop"

echo "Setting Up npm"
cd 
mkdir ~/.npm-global 
npm config set prefix '~/.npm-global' 

echo "Setting Up zsh shell"
curl -fsSL https://fnm.vercel.app/install | sh
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
sh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.sh)
chsh -s $(which zsh)

