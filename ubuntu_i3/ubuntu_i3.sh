#!/bin/bash

cd
cd scripts/ubuntu_i3
sudo cp -R 01norecommend /etc/apt/apt.conf.d/

echo "Installing packages"
cd
sudo apt update && sudo apt full-upgrade
sudo apt install thunar thunar-volman thunar-media-tags-plugin thunar-archive-plugin file-roller sddm xfce4-power-manager gvfs chkrootkit qt5-style-kvantum qt5ct zsh sysstat wget transmission zathura zathura-pdf-poppler acpi feh rofi zstd xclip xsel x11-xserver-utils pipewire pipewire-alsa pipewire-jack pipewire-pulse wireplumber alsa-utils apt-transport-https cmake meson pkg-config unzip curl xorg ckb-next bleachbit build-essential fd-find sxhkd dunst pulsemixer libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev ubuntu-drivers-common chrony curl papirus-icon-theme i3-wm

sudo apt install lxappearance
sudo ubuntu-drivers autoinstall


LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep '"tag_name":' |  sed -E 's/.*"v*([^"]+)".*/\1/')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
sudo tar xf lazygit.tar.gz -C /usr/local/bin lazygit

echo "Installing pacstall and packages"
sudo bash -c "$(curl -fsSL https://git.io/JsADh || wget -q https://git.io/JsADh -O -)"
pacstall -I emacs neovim insync-deb alacritty


echo "Installing brave-browser"
cd
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser

echo "Installing picom"
cd 
git clone https://github.com/pijulius/picom.git
cd picom
sudo apt install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev --no-install-recommends
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install

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
ln -s $HOME/.dots/i3/ ~/.config/
ln -s $HOME/.dots/eww/ ~/.config/
ln -s $HOME/.dots/alacritty/ ~/.config/

echo "Setting Up Systemd"
cd  
sudo systemctl set-default graphical.target 
systemctl --user enable --now wireplumber.service pipewire-pulse.socket pipewire.socket pipewire-pulse.service pipewire.service pipewire-pulse.socket pipewire.socket pipewire-pulse.service pipewire.service

echo "Setting up Scripts"
cd 
cd scripts/ubuntu_i3
sudo install -Dm755 i3start "/usr/local/bin/i3start"
sudo install -Dm755 i3monitor "/usr/local/bin/i3monitor" 
sudo install -Dm755 i3volume "/usr/local/bin/i3volume"

echo "Setting up text editors"
git clone https://gitlab.com/ahsanur041/neovim ~/.config/nvim
git clone https://gitlab.com/ahsanur041/emacs_config ~/.emacs.d/

echo "Setting Up npm"
cd 
mkdir ~/.npm-global 
npm config set prefix '~/.npm-global' 

echo "Setting Up zsh shell"
curl -fsSL https://fnm.vercel.app/install | sh
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh)
chsh -s $(which zsh)

echo "Setup flatpak and snap"
cd 
sudo apt install flatpak 
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
