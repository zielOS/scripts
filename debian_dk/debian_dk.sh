#!/bin/bash

cd
cd scripts/debian_dk
sudo cp -R 01norecommend /etc/apt/apt.conf.d/
sudo cp -R sources.list /etc/apt/
sudo cp -R preferences /etc/apt/

sudo apt update && sudo apt install nala zstd
echo "Installing packages"
cd
sudo nala update && sudo nala upgrade
sudo nala install nemo nemo-fileroller gvfs zsh sysstat wget transmission-gtk zathura zathura-pdf-poppler acpi rofi xclip xsel x11-xserver-utils pipewire pipewire-alsa pipewire-jack pipewire-pulse wireplumber alsa-utils apt-transport-https cmake meson pkg-config unzip curl xorg ckb-next bleachbit build-essential ripgrep fd-find sxhkd dunst pamixer curl papirus-icon-theme fzf lf firefox

echo "Installing pacstall and packages"
sudo bash -c "$(curl -fsSL https://git.io/JsADh || wget -q https://git.io/JsADh -O -)"
pacstall -I emacs neovim 

echo "Installing picom"
cd 
git clone https://github.com/zielOS/picom.git
cd picom
sudo nala install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson curl
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install

echo "Installing eww"
cd && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup default nightly
git clone https://github.com/elkowar/eww
cd eww
cargo build --release --no-default-features --features x11


echo "Installing Dot files"
cd 
sudo rm -R ~/.config/
rm -R .zshrc
mkdir ~/.config  
git clone https://gitlab.com/ahsanur041/mydots.git ~/.dots
ln -s $HOME/.dots/gtk-3.0/ ~/.config/ 
ln -s $HOME/.dots/lazygit/ ~/.config/
ln -s $HOME/.dots/wallpapers/ ~/.config/
ln -s $HOME/.dots/zathura/ ~/.config/
ln -s $HOME/.dots/rofi/ ~/.config/
ln -s $HOME/.dots/zsh/ ~/.config/
ln -s $HOME/.dots/.zshrc ~/
ln -s $HOME/.dots/.fonts ~/
ln -s $HOME/.dots/.themes/ ~/
ln -s $HOME/.dots/.gtkrc-2.0/ ~/
ln -s $HOME/.dots/.Xresources ~/
ln -s $HOME/.dots/picom ~/.config/
ln -s $HOME/.dots/dunst ~/.config/
ln -s $HOME/.dots/ckb-next ~/.config/
ln -s $HOME/.dots/sxhkd/ ~/.config/
ln -s $HOME/.dots/dk/ ~/.config/
ln -s $HOME/.dots/eww/ ~/.config/
ln -s $HOME/.dots/alacritty/ ~/.config/

echo "Setting Up Systemd"
cd  
sudo systemctl set-default graphical.target 
systemctl --user enable --now wireplumber.service pipewire-pulse.socket pipewire.socket pipewire-pulse.service pipewire.service pipewire-pulse.socket pipewire.socket pipewire-pulse.service pipewire.service
/

echo "Setting Up npm"
cd 
mkdir ~/.npm-global 
npm config set prefix '~/.npm-global' 

echo "Setting Up zsh shell"
curl -fsSL https://fnm.vercel.app/install | sh
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh)
chsh -s $(which zsh)

