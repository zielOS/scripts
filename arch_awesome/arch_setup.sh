cfdisk /dev/nvme0n1 && mkfs.vfat -F 32 /dev/nvme0n1p1 && cryptsetup -c aes-xts-plain64 -s 512 -y luksFormat /dev/nvme0n1p2 && cryptsetup luksOpen /dev/nvme0n1p2 cryptroot && mkfs.btrfs /dev/mapper/cryptroot && mkdir /mnt/arch && mount /dev/mapper/cryptroot /mnt/arch

btrfs su cr /mnt/arch/@  && btrfs su cr /mnt/arch/@home && btrfs su cr /mnt/arch/@opt  && btrfs su cr /mnt/arch/@tmp && btrfs su cr /mnt/arch/@var && btrfs su cr /mnt/arch/@log &&  btrfs su cr /mnt/arch/@audit  && btrfs su cr /mnt/arch/@snapshots && umount /mnt/arch

mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@ /dev/mapper/cryptroot /mnt/arch && mkdir /mnt/arch/home && mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@home /dev/mapper/cryptroot /mnt/arch/home && mkdir /mnt/arch/opt && mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@opt /dev/mapper/cryptroot /mnt/arch/opt  && mkdir /mnt/arch/tmp && mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@tmp /dev/mapper/cryptroot /mnt/arch/tmp && mkdir /mnt/arch/var && mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@var /dev/mapper/cryptroot /mnt/arch/var && mkdir /mnt/arch/var/log && mount -o nmoatime,compress=zstd,space_cache=v2,discard=async,subvol=@log /dev/mapper/cryptroot /mnt/arch/var/log && mkdir /mnt/arch/var/log/audit && mount -o nmoatime,compress=zstd,space_cache=v2,discard=async,subvol=@audit /dev/mapper/cryptroot /mnt/arch/var/log/audit && mkdir /mnt/arch/.snapshots && mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@snapshots /dev/mapper/cryptroot /mnt/arch/.snapshots 
  
pacstrap /mnt/arch linux linux-headers base base-devel git neovim linux-firmware intel-ucode arch-install-scripts mkinitcpio reflector

arch-chroot /mnt/arch

mount /dev/nvme0n1p1 /boot
genfstab -U / >> /etc/fstab

reflector --verbose --country 'CA,US' -l 25 --sort rate --save /etc/pacman.d/mirrorlist

pacman -S unzip zip unrar btrfs-progs dosfstools wget curl neofetch upower zathura zathura-pdf-poppler python-pynvim neovim ripgrep fd zsh zsh-completions zoxide fzf fuse flatpak lazygit xdg-user-dirs xdg-user-dirs-gtk xdg-utils nemo nemo-fileroller nemo-preview gvfs libx11 libxinerama libxft freetype2 feh rofi dunst flameshot xsel xclip xfce4-power-manager xorg nvidia nvidia-utils nvidia-settings mesa rng-tools haveged lynis firejail audit sysstat apparmor snapper snap-pac grub mlocate sxiv fdupes acpi tmux keepassxc tldr linux linux-headers


ln -sf /usr/share/zoneinfo/Canada/Mountain /etc/localtime && hwclock --systohc && nvim /etc/locale.gen && locale-gen && echo "LANG=en_CA.UTF-8" >> /etc/locale.conf


nvim /etc/mkinitcpio.conf && mkinitcpio -p linux

MODULES=(btrfs nvidia nvidia_modeset nvidia_uvm nvidia_drm)

** GRUB_SETUP
pacman -S grub efibootmgr

passwd && useradd -m -G users,wheel,audio,video -s /bin/bash ahsan && passwd ahsan && EDITOR=nvim visudo

nvim /etc/default/grub
GRUB_CMDLINE_LINUX="cryptdevice=UUID=82ddf770-23d4-407a-9e71-77e189581d11:cryptroot root=/dev/mapper/cryptroot"

grub-install --target=x86_64-efi --efi-directory=/boot && grub-install --target=x86_64-efi --efi-directory=/boot --removable && grub-mkconfig -o /boot/grub/grub.cfg

** Systemd Setup

systemd-firstboot --prompt --setup-machine-id && systemctl enable NetworkManager fstrim.timer acpid systemd-timesyncd sysstat auditd


# Post-install chroot
cryptsetup luksOpen /dev/nvme0n1p2 cryptroot && mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@ /dev/mapper/cryptroot /mnt/arch && mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@home /dev/mapper/cryptroot /mnt/arch/home  && mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@opt /dev/mapper/cryptroot /mnt/arch/opt && mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@tmp /dev/mapper/cryptroot /mnt/arch/tmp && mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@var /dev/mapper/cryptroot /mnt/arch/var && mount -o nmoatime,compress=zstd,space_cache=v2,discard=async,subvol=@log /dev/mapper/cryptroot /mnt/arch/var/log && mount -o nmoatime,compress=zstd,space_cache=v2,discard=async,subvol=@audit /dev/mapper/cryptroot /mnt/arch/var/log/audit && mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@snapshots /dev/mapper/cryptroot /mnt/arch/.snapshots && arch-chroot /mnt/arch


nvim /etc/modprobe.d/nvidia.conf
options nvidia-drm modeset=1 
options nvidia NVreg_UsePageAttributeTable=1


nvim /etc/modprobe.d/nvidia-power-management.conf
options nvidia NVreg_PreserveVideoMemoryAllocations=1 NVreg_TemporaryFilePath=/tmp


#scaling apps
--force-device-scale-factor=1.75 %U

#setup snapper
sudo umount /.snapshots/ && sudo rm -r /.snapshots/ && sudo snapper -c root create-config / && sudo btrfs subvolume delete /.snapshots && sudo mkdir /.snapshots && sudo mount -a && sudo chmod 750 /.snapshots && sudo lvim /etc/snapper/configs/root && sudo systemctl enable --now snapper-timeline.timer && sudo systemctl enable --now snapper-cleanup.timer && yay -S snap-pac-grub snapper-gui && sudo mkdir /etc/pacman.d/hooks && sudo lvim /etc/pacman.d/hooks/50-bootbackup.hook

[Trigger]
Operation = Upgrade
Operation = Install
Operation = Remove
Type = Path
Target = boot/*

[Action]
Depends = rsync
Description = Backing up /boot...
When = PreTransaction
Exec = /usr/bin/rsync -a --delete /boot /.bootbackup

# chrome sandbox
sudo chown root:root chrome-sandbox
sudo chmod 4755 chrome-sandbox

sudo lvim /usr/share/gvfs/mounts/network.mount
AutoMount=false

sudo nvim /etc/sysctl.d/harden.conf
kernel.kptr_restrict=2
kernel.dmesg_restrict=1
kernel.printk=3 3 3 3
kernel.unprivileged_bpf_disabled=1
net.core.bpf_jit_harden=2
dev.tty.ldisc_autoload=0
vm.unprivileged_userfaultfd=0
kernel.kexec_load_disabled=1
kernel.sysrq=4
kernel.unprivileged_userns_clone=0
kernel.perf_event_paranoid=3
net.ipv4.tcp_syncookies=1
net.ipv4.tcp_rfc1337=1
net.ipv4.conf.all.rp_filter=1
net.ipv4.conf.default.rp_filter=1
net.ipv4.conf.all.accept_redirects=0
net.ipv4.conf.default.accept_redirects=0
net.ipv4.conf.all.secure_redirects=0
net.ipv4.conf.default.secure_redirects=0
net.ipv6.conf.all.accept_redirects=0
net.ipv6.conf.default.accept_redirects=0
net.ipv4.conf.all.send_redirects=0
net.ipv4.conf.default.send_redirects=0
net.ipv4.icmp_echo_ignore_all=1
net.ipv4.conf.all.accept_source_route=0
net.ipv4.conf.default.accept_source_route=0
net.ipv6.conf.all.accept_source_route=0
net.ipv6.conf.default.accept_source_route=0
net.ipv6.conf.all.accept_ra=0
net.ipv6.conf.default.accept_ra=0
net.ipv4.tcp_sack=0
net.ipv4.tcp_dsack=0
net.ipv4.tcp_fack=0
kernel.yama.ptrace_scope=2
vm.mmap_rnd_bits=32
vm.mmap_rnd_compat_bits=16
fs.protected_symlinks=1
fs.protected_hardlinks=1
fs.protected_fifos=2
fs.protected_regular=2

 -- WARNING -- This system is for the use of authorized users only. Individuals 
 using this computer system without authority or in excess of their authority 
 are subject to having all their activities on this system monitored and 
 recorded by system personnel. Anyone using this system expressly consents to 
 such monitoring and is advised that if such monitoring reveals possible 
 evidence of criminal activity system personal may provide the evidence of such 
 monitoring to law enforcement officials.
