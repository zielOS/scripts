#!/bin/bash

# install packages from official repos
echo "Installing packages from official repos"
sudo pacman -S unzip zip unrar btrfs-progs dosfstools thunar thunar-volman thunar-archive-plugin thunar-media-tags-plugin tumbler zathura zathura-pdf-poppler wget pipewire-pulse curl python-pip neofetch xdg-user-dirs  nvidia-dkms nvidia-utils mesa rng-tools haveged upower greetd greetd-tuigreet lazygit lynis firejail audit sysstat apparmor acpid fzf flatpak fdupes sxiv ranger celluloid power-profiles-daemon swaybg swayidle wl-clipboard wofi foot grim slurp wf-recorder vulkan-tools vulkan-headers vulkan-validation-layers nodejs npm rustup transmission-gtk cmake boost tmux polkit-gnome sxiv gammastep lxappearance curl ttf-jetbrains-mono-nerd ttf-firacode-nerd gnome-keyring


echo "Downloading workstation-dots"
cd && sudo rm -R ~/.config/
cd && mkdir ~/.config 
git clone https://github.com/Ahsan041/workstation-dots.git ~/.dots


#------------------------------------------------------------------
#---- SETUP HYPRLAND & DE -----------------------------------------
#------------------------------------------------------------------

#---- Prepare AUR ---------------------------------
echo "Prepare AUR"
cd && mkdir AUR

#---- Setup Hyprland Functionality ----------------

cd && cd AUR && git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si -r && cd

echo "Install & Setup Hyprland"
cd && cd AUR && git clone https://aur.archlinux.org/hyprland-nvidia-git.git
cd hyprland-nvidia-git
makepkg -si -r
cd && ln -s $HOME/.dots/hypr $HOME/.config/ 
cd && cd scripts/arch_hyprland && sudo install -Dm755 hyprland-nvidia "/usr/local/bin/hyprland-nvidia"
cd && cd scripts/arch_hyprland && sudo install -Dm755 hyprstart "/usr/local/bin/hyprstart"

echo "Install & Setup swhkd"
cd && cd AUR && git clone https://github.com/waycrate/swhkd
cd swhkd && make && sudo make install
cd && ln -s $HOME/.dots/swhkd $HOME/.config/
cd && cd scripts/arch_hyprland && sudo install -Dm755 hyprkeys "/usr/local/bin/hyprkeys"

echo "Install Desktop Portal"
cd && cd AUR && git clone https://aur.archlinux.org/xdg-desktop-portal-hyprland-git.git
cd xdg-desktop-portal-hyprland-git
makepkg -si -r && cd 

echo "Install Pyprland"
cd && cd AUR && git clone https://aur.archlinux.org/pyprland.git
cd pyprland && makepkg -si -r && cd

echo "Install vaapi-drivers"
cd && cd AUR && git clone https://aur.archlinux.org/nvidia-vaapi-driver-git.git
cd nvidia-vaapi-driver-git
makepkg -si -r && cd


#---- Setup Hyprland Desktop Elemenets ------------

echo "Install & Setup Waybar"
cd && cd AUR && git clone https://aur.archlinux.org/waybar-hyprland-git.git
cd waybar-hyprland-git
makepkg -si -r
cd && ln -s $HOME/.dots/waybar $HOME/.config/ 
cd && cd scripts/arch_hyprland && sudo install -Dm755 hyprbar "/usr/local/bin/hyprbar"

echo "Install & Setup EWW"
cd && cd AUR && git clone https://aur.archlinux.org/eww-wayland.git
cd eww-wayland
makepkg -si -r
cd && ln -s $HOME/.dots/eww $HOME/.config/

echo "Install & Setup Swaync"
cd && cd AUR && git clone https://aur.archlinux.org/swaync.git
cd swaync
makepkg -si -r
cd && ln -s $HOME/.dots/swaync $HOME/.config/

echo "Install & Setup Swaylock"
cd && cd AUR && git clone https://aur.archlinux.org/swaylock-effects.git
cd swaylock-effects
makepkg -si -r
cd && cd scripts/arch_hyprland && sudo install -Dm755 hyprlock "/usr/local/bin/hyprlock" 

echo "Install & Setup Avizo"
cd && cd AUR && git clone https://aur.archlinux.org/avizo.git
cd avizo
makepkg -si -r
cd && ln -s $HOME/.dots/avizo $HOME/.config/


#---- Setup Hyprland Theme ------------------------

echo "Install Icons"
cd && sudo pacman -S papirus-icon-theme
cd && cd AUR && git clone https://aur.archlinux.org/papirus-folders-catppuccin-git.git
cd papirus-folders-catppuccin-git
makepkg -si -r && cd

echo "Install gtk theme"
cd && cd AUR && git clone https://aur.archlinux.org/catppuccin-gtk-theme-mocha.git
cd catppuccin-gtk-theme-mocha
makepkg -si -r && cd

echo "Install Cursors"
cd && cd AUR && git clone https://aur.archlinux.org/catppuccin-cursors-mocha.git
cd catppuccin-cursors-mocha
makepkg -si -r && cd

cd && cd scripts/arch_hyprland && sudo install -Dm755 hyprtheme "/usr/local/bin/hyprtheme"
papirus-folders -C cat-mocha-lavender --theme Papirus-Dark


#--------------------------------------------------
#---- SETUP EMACS ---------------------------------
#--------------------------------------------------


#---- Setup Emacs & Emacs Pkgs --------------------
echo "Setup Emacs"

#---- Install Emacs -------------------------------
echo "emacs29-git"
cd && cd AUR && git clone https://aur.archlinux.org/emacs29-git.git
cd emacs29-git
makepkg -si -r 
cd && ln -s $HOME/.dots/emacs $HOME/

#---- Setup Doom Emacs ----------------------------
cd && git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
cd && sudo rm -R $HOME/.emacs.d


#-------------------------------------
#---- SETUP NEOVIM -------------------
#-------------------------------------

#---- Install Neovim -----------------
echo "Setup & Install Neovim"
sudo pacman -S neovim ripgrep fd python-pynvim

echo "nodejs-neovim"
cd && git clone https://aur.archlinux.org/nodejs-neovim.git
cd nodejs-neovim
makepkg -si -r && cd

echo "setup lunarvim"
cd && mkdir ~/.npm-global && npm config set prefix '~/.npm-global'
LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh) 
sudo rm -R $HOME/.config/lvim
ln -s $HOME/.dots/lvim $HOME/.config/


#-------------------------------------------------
#---- SETUP OTHER APPS----------------------------
#-------------------------------------------------

echo "Setup ckb-next"
cd && cd AUR && git clone https://aur.archlinux.org/ckb-next.git
cd ckb-next
makepkg -si -r
cd && ln -s $HOME/.dots/ckb-next $HOME/.config/

echo "aide"
cd && cd AUR && git clone https://aur.archlinux.org/aide.git
cd aide
makepkg -si -r && cd

echo "insync"
cd && cd AUR && git clone https://aur.archlinux.org/insync.git
cd insync
makepkg -si -r && cd

echo "acct"
cd && cd AUR &&git clone https://aur.archlinux.org/acct.git
cd acct
makepkg -si -r && cd


#-----------------------------------------
#---- SETUP SNAPD ------------------------
#-----------------------------------------
echo "snapd"
cd && git clone https://aur.archlinux.org/snapd.git
cd snapd
makepkg -si -r && cd


#-------------------------------------------------
#---- SETUP OTHER DOTS ---------------------------
#-------------------------------------------------
                 
echo "Installing Other Dot files" 
ln -s $HOME/.dots/kitty $HOME/.config/ 
ln -s $HOME/.dots/lazygit $HOME/.config/
ln -s $HOME/.dots/TODOS $HOME/ 
ln -s $HOME/.dots/wlogout $HOME/.config/ 
ln -s $HOME/.dots/wofi $HOME/.config/
ln -s $HOME/.dots/zathura $HOME/.config/
ln -s $HOME/.dots/electron-flags.conf $HOME/.config/ 
ln -s $HOME/.dots/electron13-flags.conf $HOME/.config/



#-------------------------------------------------
#---- SETUP OTHER SCRIPTS ------------------------
#-------------------------------------------------

echo "Setting up Scripts"
cd && cd scripts/arch_hyprland
sudo install -Dm755 hypridle "/usr/local/bin/hypridle"
sudo install -Dm755 hyprlogout "/usr/local/bin/hyprlogout"
sudo install -Dm755 hyprmenu "/usr/local/bin/hyprmenu"
sudo install -Dm755 hyprpolkit "/usr/local/bin/hyprpolkit"
sudo install -Dm755 hyprshot "/usr/local/bin/hyprshot"
sudo install -Dm755 hyprsome "/usr/local/bin/hyprsome"
sudo install -Dm755 hyprterm "/usr/local/bin/hyprterm"
sudo install -Dm755 hyprwall "/usr/local/bin/hyprwall"



#-----------------------------------------
#---- SETUP SHELL ------------------------
#-----------------------------------------
cd && sudo pacman -S zsh zsh-completions 
cd && echo "Setting Up Zsh Shell"
curl -fsSL https://fnm.vercel.app/install | bash
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
sudo rm -R $HOME/.zshrc
ln -s $HOME/.dots/.zshrc $HOME/
ln -s $HOME/.dots/zsh $HOME/.config/



#-----------------------------------------
#---- SETUP SYSTEMD ----------------------
#-----------------------------------------

echo "Setup Systemd"
sudo systemctl set-default graphical.target 
systemctl --user enable --now wireplumber.service pipewire-pulse.socket pipewire.socket pipewire-pulse.service pipewire.service pipewire-pulse.socket pipewire.socket pipewire-pulse.service pipewire.service


