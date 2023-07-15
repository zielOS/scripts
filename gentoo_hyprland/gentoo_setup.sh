*** BTRFS
cfdisk /dev/nvme0n1 && mkfs.vfat -F32 /dev/nvme0n1p1 && cryptsetup -c aes-xts-plain64 -s 512 -y luksFormat /dev/nvme0n1p2 && cryptsetup luksOpen /dev/nvme0n1p2 cryptroot && mkfs.btrfs /dev/mapper/cryptroot && mkdir /mnt/gentoo && mount /dev/mapper/cryptroot /mnt/gentoo 


btrfs su cr /mnt/gentoo/@  && btrfs su cr /mnt/gentoo/@home && btrfs su cr /mnt/gentoo/@opt && btrfs su cr /mnt/gentoo/@tmp && btrfs su cr /mnt/gentoo/@var && btrfs su cr /mnt/gentoo/@log &&  btrfs su cr /mnt/gentoo/@audit  && btrfs su cr /mnt/gentoo/@snapshots && umount /mnt/gentoo 

mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@ /dev/mapper/cryptroot /mnt/gentoo && mkdir /mnt/gentoo/home && mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@home /dev/mapper/cryptroot /mnt/gentoo/home && mkdir /mnt/gentoo/opt && mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@opt /dev/mapper/cryptroot /mnt/gentoo/opt  && mkdir /mnt/gentoo/tmp && mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@tmp /dev/mapper/cryptroot /mnt/gentoo/tmp && mkdir /mnt/gentoo/var && mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@var /dev/mapper/cryptroot /mnt/gentoo/var && mkdir /mnt/gentoo/var/log && mount -o nmoatime,compress=zstd,space_cache=v2,discard=async,subvol=@log /dev/mapper/cryptroot /mnt/gentoo/var/log && mkdir /mnt/gentoo/var/log/audit && mount -o nmoatime,compress=zstd,space_cache=v2,discard=async,subvol=@audit /dev/mapper/cryptroot /mnt/gentoo/var/log/audit && mkdir /mnt/gentoo/.snapshots && mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@snapshots /dev/mapper/cryptroot /mnt/gentoo/.snapshots 

* Download gentoo

cd /mnt/gentoo && wget https://bouncer.gentoo.org/fetch/root/all/releases/amd64/autobuilds/20230618T170201Z/stage3-amd64-hardened-openrc-20230618T170201Z.tar.xz && tar xpvf stage3-*.tar.xz --xattrs-include='*.*' --numeric-owner


*** make.conf
rm -R /mnt/gentoo/etc/portage/make.conf && nano -w /mnt/gentoo/etc/portage/make.conf

# These settings were set by the catalyst build script that automatically
# built this stage.
# Please consult /usr/share/portage/config/make.conf.example for a more
# detailed example.
COMMON_FLAGS="-march=native -O2 -pipe"
CPU_FLAGS_X86="aes avx avx2 f16c fma3 mmx mmxext pclmul popcnt rdrand sha sse sse2 sse3 sse4_1 sse4_2 ssse3"
CFLAGS="${COMMON_FLAGS}"
CXXFLAGS="${COMMON_FLAGS}"
FCFLAGS="${COMMON_FLAGS}"
FFLAGS="${COMMON_FLAGS}"
RUSTFLAGS="-C opt-level=3 -C target-cpu=native"
MAKEOPTS="-j22"
NOCOMMON_OVERRIDE_LIBTOOL="yes"
#ACCEPT_KEYWORDS="~amd64"
ACCEPT_LICENSE="*"
VIDEO_CARDS="nvidia"
USE="-elogind systemd -gnome  -berkdb  -kde -ccache  tpm zstd gtk policykit \
      clamav -coreaudio -ios -ipod -ieee1394  -motif gui pulseaudio \
      -emboss -3dfx -altivec -smartcard -ibm wayland -nls -nas zstd pam  \
      -neon -nntp -cups -quicktime nvidia sound-server vim qt6 apparmor \
      pie gstreamer X upower hardened udev alsa audit dbus tiff jpeg"
#RUBY_TARGETS="ruby24 ruby25"
# NOTE: This stage was built with the bindist Use flag enabled
PORTDIR="/var/db/repos/gentoo"
DISTDIR="/var/cache/distfiles"
PKGDIR="/var/cache/binpkgs"

# This sets the language of build output to English.
# Please keep this setting intact when reporting bugs.
LC_MESSAGES=C
GRUB_PLATFORMS="efi-64"



**** keywords
rm -R /mnt/gentoo/etc/portage/package.accept_keywords && nano -w /mnt/gentoo/etc/portage/package.accept_keywords

=app-editors/emacs-29.0.9999-r1 ** ~amd64
=gui-wm/hyprland-9999-r4 ** ~amd64
=gui-libs/xdg-desktop-portal-hyprland-9999 ** ~amd64
=gui-apps/waybar-9999 ** ~amd64
=app-backup/grub-btrfs-9999 ** ~amd64
>=dev-qt/qtcore-6 ~amd64
>=dev-qt/qtdbus-6 ~amd64
>=dev-qt/qtconcurrent-6 ~amd64
>=dev-qt/qtnetwork-6 ~amd64
>=dev-qt/qttest-6 ~amd64
>=dev-qt/qtgui-6 ~amd64
>=dev-qt/qtwidgets-6 ~amd64
>=dev-qt/qtdeclarative-6 ~amd64
>=dev-qt/qtwayland-6 ~amd64
>=dev-qt/qtx11extras-6 ~amd64
>=dev-qt/qtbase-6 ~amd64
>=dev-qt/qtshadertools-6 ~amd64
eselect/eselect-repository ~amd64
dev-vcs/git ~amd64
sys-devel/gcc ~amd64
dev-util/cmake ~amd64
dev-lang/rust ~amd64
virtual/rust ~amd64
app-eselect/eselect-rust ~amd64
sys-libs/libomp ~amd64 
sys-config/ltoize ~amd64
app-portage/lto-rebuild ~amd64
sys-kernel/gentoo-sources ~amd64 
sys-kernel/linux-firmware ~amd64 
sys-kernel/linux-headers ~amd64 
sys-kernel/genkernel ~amd64 
sys-apps/fwupd ~amd64  
sys-fs/cryptsetup ~amd64 
sys-firmware/intel-microcode ~amd64
app-arch/unzip ~amd64
app-arch/zip ~amd64
app-arch/unrar ~amd64
sys-fs/btrfs-progs ~amd64
sys-fs/dosfstools ~amd64
net-misc/wget ~amd64
net-misc/curl ~amd64
app-misc/neofetch ~amd64
app-misc/ckb ~amd64
sys-power/upower ~amd64
gui-apps/wl-clipboard ~amd64
app-portage/cpuid2cpuflags ~amd64
app-admin/sudo ~amd64
app-text/zathura ~amd64
app-text/zathura-meta ~amd64
app-office/libreoffice ~amd64
x11-themes/papirus-icon-theme ~amd64
dev-python/pynvim ~amd64
app-editors/neovim ~amd64 
sys-apps/ripgrep ~amd64
sys-apps/fd ~amd64
app-shells/zsh ~amd64
app-shells/zsh-completions ~amd64
app-shells/gentoo-zsh-completions ~amd64
app-shells/zoxide ~amd64 
dev-util/fnm ~amd64
app-shells/fzf ~amd64 
sys-fs/fuse:0 ~amd64
sys-apps/flatpak ~amd64
sci-misc/jupyterlab-desktop-bin ~amd64 
dev-vcs/lazygit ~amd64
x11-misc/xdg-user-dirs ~amd64
gnome-extra/nemo ~amd64 
gnome-extra/nemo-fileroller ~amd64
x11-misc/xdg-utils ~amd64 
x11-drivers/nvidia-drivers ~amd64  
media-libs/mesa ~amd64
x11-apps/mesa-progs ~amd64 
LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)


sys-apps/grep ~amd64
app-forensics/aide ~amd64
net-analyzer/snort ~amd64
sys-apps/rng-tools ~amd64 
sys-apps/haveged ~amd64 
app-forensics/lynis ~amd64
sys-apps/firejail ~amd64 
sys-process/audit ~amd64
app-admin/sysstat ~amd64
sys-apps/apparmor ~amd64
sys-apps/apparmor-utils ~amd64
sys-libs/libapparmor ~amd64
sec-policy/apparmor-profiles ~amd64
app-antivirus/lkrg ~amd64
sys-process/acct ~amd64
gui-apps/eww ~amd64 
gui-apps/swaybg ~amd64
gui-apps/swayidle ~amd64 
gui-apps/wofi ~amd64 
app-misc/nwg-look ~amd64 
gui-apps/foot ~amd64
gui-apps/swaync ~amd64
gui-apps/wf-recorder ~amd64
gui-libs/greetd ~amd64
gui-apps/tuigreet ~amd64
gui-apps/grim ~amd64
gui-apps/slurp ~amd64
app-backup/snapper ~amd64
app-backup/grub-btrfs ~amd64
sys-boot/grub ~amd64
net-misc/dhcpcd ~amd64
net-misc/netifrc ~amd64
sys-devel/libtool ~amd64
net-misc/chrony ~amd64
app-admin/sysklogd ~amd64
sys-process/cronie ~amd64
sys-apps/mlocate ~amd64
app-crypt/seahorse ~amd64
app-crypt/libsecret ~amd64
app-editors/vim ~amd64
app-editors/vim-core ~amd64
app-portage/portage-bashrc-mv ~amd64
app-portage/eix ~amd64
media-gfx/sxiv ~amd64
x11-terms/kitty ~amd64
x11-terms/kitty-terminfo ~amd64
x11-terms/kitty-shell-integration ~amd64
app-misc/fdupes ~amd64
app-misc/ranger ~amd64
sys-power/acpi ~amd64
app-misc/resolve-march-native ~amd64
app-misc/grc ~amd64
app-misc/tmux ~amd64
media-video/celluloid ~amd64
gnome-base/gnome-keyring ~amd64
sys-libs/glibc ~amd64
sys-apps/locale-gen ~amd64
x11-misc/gammastep ~amd64
app-admin/keepassxc ~amd64
www-client/brave-bin ~amd64
gui-apps/wdisplays ~amd64
dev-libs/date ~amd64
x11-apps/xcur2png ~amd64
dev-python/jupyterlab ~amd64
dev-python/async-lru ~amd64
dev-python/jupyter-lsp ~amd64
dev-python/jupyterlab-server ~amd64
dev-python/hatch-jupyter-builder ~amd64
dev-python/json5 ~amd64
dev-util/nvidia-cuda-toolkit ~amd64
gui-libs/egl-gbm ~amd64
gui-libs/egl-wayland ~amd64
virtual/linux-sources ~amd64




rm -R /mnt/gentoo/etc/portage/package.use && nano -w /mnt/gentoo/etc/portage/package.use

*/* PYTHON_TARGETS: python3_11
*/* LLVM_TARGETS: X86
media-libs/vulkan-loader layers
media-libs/mesa vulkan wayland lm-sensors
x11-drivers/nvidia-drivers wayland static-libs
app-editors/neovim lto
dev-libs/libxml2 icu
media-libs/harfbuzz icu
>=media-libs/libpng-1.6.39 -apng
net-libs/nodejs lto npm pax-kernel
dev-lang/rust clippy miri nightly rust-analyzer rustfmt system-llvm
net-p2p/transmission gtk -qt5 -qt6
sys-config/ltoize keep-nocommon clang
dev-util/cmake -emacs ncurses -qt5
media-fonts/iosevka X iosevka-aile
app-text/xmlto text
xfce-base/thunar udisks
gnome-base/gvfs udisks
dev-libs/libdbusmenu gtk3
app-crypt/gcr gtk
sys-apps/kmod zstd
sys-boot/grub:2 device-mapper
app-admin/sysstat lto lm-sensors
sys-libs/zlib minizip
app-text/poppler cairo
dev-lang/python lto pgo ensurepip tk hardened
gui-apps/waybar experimental libinput tray logind network popups pipewire upower wifi udev
sys-devel/gcc lto pgo graphite jit default-stack-clash-protection rustcfdisk /dev/nvme0n1 && mkfs.vfat -F 32 /dev/nvme0n1p1 && mkswap /dev/nvme0n1p2 && swapon /dev/nvme0n1p2 && cryptsetup -c aes-xts-plain64 -s 512 -y luksFormat /dev/nvme0n1p3 && cryptsetup luksOpen /dev/nvme0n1p3 cryptroot && mkfs.btrfs /dev/mapper/cryptroot && mkdir /mnt/arch && mount /dev/mapper/cryptroot /mnt/arch
sys-apps/firejail apparmor private-home
app-editors/emacs alsa dynamic-loading gfile gmp gtk gui gzip-el harfbuzz imagemagick inotify jit jpeg motif png ssl svg threads tiff tree-sitter zlib -X
app-text/ghostscript-gpl cups
dev-python/PyQt5 widgets
media-sound/pulseaudio -daemon
media-video/pipewire sound-server
gui-apps/swaybg gdk-pixbuf
gui-apps/eww wayland -X
gui-apps/swaylock gdk-pixbuf
gui-apps/swaync scripting
sys-apps/kmod tools
gui-apps/grim jpeg
dev-qt/qtbase opengl egl eglfs gles2-only
dev-qt/qtdeclarative opengl
gui-libs/xdg-desktop-portal-hyprland systemd
sys-apps/xdg-desktop-portal screencast geolocation
www-client/firefox lto pgo wayland -X -telemetry hwaccel -jack -jumbo-build screencast openh264 pulseaudio clanglto-O3.conf -system-av1 -system-harfbuzz -system-icu -system-jpeg -system-libevent -system-libvpx -system-webp -eme-free
gui-wm/hyprland X systemd video_cards_nvidia
net-vpn/protonvpn-gui python_targets_python3_11
media-video/ffmpeg x264
sys-apps/systemd policykit
gui-libs/wlroots tinywl
media-sound/mpg123 -pulseaudio
media-libs/libpng apng
dev-qt/qtgui eglfs egl dbus
sys-libs/gdbm berkdb
dev-qt/qtwidgets dbus
sys-kernel/gentoo-sources experimental
dev-qt/qtbase opengl egl eglfs gles2-only
dev-qt/qtdeclarative opengl
dev-libs/boost context
dev-libs/boehm-gc cxx
x11-base/xwayland xcsecurity
virtual/libcrypt static-libs
sys-libs/libxcrypt static-libs
gui-libs/wlroots vulkan libinput drm
media-fonts/nerd-fonts jetbrainsmono firacode
gui-libs/gtk-layer-shell introspection
net-wireless/wpa_supplicant dbus
net-p2p/transmission gtk -qt5 -qt6
net-libs/libssh server
sys-config/ltoize clang
sys-apps/flatpak policykit seccomp
app-admin/keepassxc browser autotype keeshare network yubikey
dev-python/PyQt5 opengl
dev-python/pillow webp
dev-python/QtPy svg printsupport
dev-python/PyQt5 network svg sql printsupport
app-crypt/gnupg nls
app-office/libreoffice branding googledrive gtk gstreamer
dev-libs/boost nls
dev-libs/xmlsec nss
sys-auth/polkit gtk daemon
app-misc/tmux vim-syntax systemd utempter
app-editors/vim terminal gpm python sound vim-pager
net-analyzer/snort threads
sys-process/cronie anacron
app-portage/eix optimization strong-security tools
media-gfx/sxiv exif gif jpeg png webp
x11-terms/kitty wayland -X
app-misc/fdupes ncurses
x11-misc/gammastep geoclue gtk appindicator wayland
dev-libs/libpcre2 pcre32


rm -R /mnt/gentoo/etc/portage/package.mask && nano -w /mnt/gentoo/etc/portage/package.mask

>=dev-lang/python-12
x11-libs/gtk+::mv

rm -R /mnt/gentoo/etc/portage/profile/package.unmask && nano -w /mnt/gentoo/etc/portage/profile/package.unmask

>=dev-qt/qtcore-6
>=dev-qt/qtdbus-6
>=dev-qt/qtconcurrent-6
>=dev-qt/qtnetwork-6
>=dev-qt/qttest-6
>=dev-qt/qtgui-6
>=dev-qt/qtwidgets-6
>=dev-qt/qtdeclarative-6
>=dev-qt/qtwayland-6
>=dev-qt/qtx11extras-6
>=dev-qt/qtbase-6
>=dev-qt/qtshadertools-6
gui-libs/xdg-desktop-portal-hyprland::guru


* setup fstab and chroot

mount /dev/nvme0n1p1 /mnt/gentoo/boot && genfstab -U /mnt/gentoo >> /mnt/gentoo/etc/fstab && mkdir --parents /mnt/gentoo/etc/portage/repos.conf && cp /mnt/gentoo/usr/share/portage/config/repos.conf /mnt/gentoo/etc/portage/repos.conf/gentoo.conf && cp --dereference /etc/resolv.conf /mnt/gentoo/etc/ && mount --types proc /proc /mnt/gentoo/proc && mount --rbind /sys /mnt/gentoo/sys && mount --make-rslave /mnt/gentoo/sys && mount --rbind /dev /mnt/gentoo/dev && mount --make-rslave /mnt/gentoo/dev && mount --bind /run /mnt/gentoo/run && mount --make-slave /mnt/gentoo/run && test -L /dev/shm && rm /dev/shm && mkdir /dev/shm && mount -t tmpfs -o nosuid,nodev,noexec shm /dev/shm && chmod 1777 /dev/shm

* chroot-into
chroot /mnt/gentoo /bin/bash
source /etc/profile
export PS1="(chroot) ${PS1}"

emerge-webrsync && emerge --sync --quiet && emerge eselect-repository dev-vcs/git 

* switch portage to git
eselect repository remove gentoo && eselect repository add gentoo git https://github.com/gentoo-mirror/gentoo.git  && emaint sync -r gentoo && eselect repository enable guru lto-overlay mv && emaint sync -r guru && emaint sync -r lto-overlay && emaint sync -r mv 

* lto setup
emerge -av ltoize lto-rebuild && lto-rebuild -r

* gcc upgrade
emerge -aq sys-devel/gcc && lto-rebuild -r && gcc-config --list-profiles && emerge --ask --oneshot --usepkg=n sys-devel/libtool && emerge  -eq --usepkg=n @system && emerge -eq --usepkg=n @world


* gcc downgrade
revdep-rebuild --library 'libstdc++.so.6' -- --exclude gcc && emerge --ask --oneshot --usepkg=n --verbose sys-devel/libtool
 
* initial-packages
emerge --sync && emerge -auvDN @world

* kernel setup
emerge -av sys-kernel/gentoo-sources sys-kernel/linux-firmware sys-kernel/linux-headers sys-kernel/genkernel sys-fs/cryptsetup sys-firmware/intel-microcode && eselect kernel set 1 && ls -l /usr/src/linux 
  
genkernel --luks --menuconfig --install all

** file related
emerge -aq app-arch/unzip app-arch/zip app-arch/unrar sys-fs/btrfs-progs sys-fs/dosfstools sys-apps/grep  x11-misc/xdg-user-dirs x11-misc/xdg-user-dirs-gtk x11-misc/xdg-utils app-misc/ranger app-misc/vifm app-text/zathura app-text/zathura-meta app-shells/fzf

** internet related
net-misc/wget net-misc/curl www-client/firefox 

** programming related
app-editors/neovim gui-apps/wl-clipboard dev-python/pynvim sys-apps/ripgrep sys-apps/fd dev-vcs/lazygit

app-misc/neofetch app-misc/ckb app-admin/sudo    

** shell related
app-shells/zsh app-shells/zsh-completions app-shells/gentoo-zsh-completions app-shells/zoxide 

** hardware-related
x11-drivers/nvidia-drivers x11-apps/mesa-progs sys-power/upower dev-util/nvidia-cuda-toolkit dev-libs/cudnn media-libs/vulkan-loader dev-util/vulkan-headers media-libs/vulkan-layers dev-java/openjdk sys-power/acpi


** security related 
app-forensics/aide sys-apps/rng-tools sys-apps/haveged app-forensics/lynis sys-apps/firejail sys-process/audit app-admin/sysstat sys-apps/apparmor sys-apps/apparmor-utils sys-libs/libapparmor sec-policy/apparmor-profiles app-antivirus/lkrg sys-process/acct app-admin/keepassxc net-analyzer/snort 

** DE-related
gui-apps/eww gui-apps/swaybg gui-apps/swayidle gui-apps/wofi app-misc/nwg-look gui-apps/wf-recorder gui-libs/greetd gui-apps/tuigreet gui-apps/grim gui-apps/slurp sys-apps/mlocate  media-video/mpv x11-terms/kitty x11-terms/kitty-shell-integration x11-terms/kitty-terminfo app-misc/tmux x11-misc/gammastep  



update  kvantum  fluent-gtk-theme  manually

 * use='-gmp-autoupdate' has disabled the following plugins from updating or
 * installing into new profiles:
 * 	 gmp-gmpopenh264
 * 	 gmp-widevinecdm



passwd && useradd -m -G users,wheel,audio,video -s /bin/bash ahsan && passwd ahsan && EDITOR=nvim visudo

grub-install --target=x86_64-efi --efi-directory=/boot && grub-install --target=x86_64-efi --efi-directory=/boot --removable && grub-mkconfig -o /boot/grub/grub.cfg

nvim /etc/default/grub
GRUB_CMDLINE_LINUX="quiet crypt_root=UUID=84c9f865-e6ad-472f-8a7a-a3659470b72c root_trim=yes init=/lib/systemd/systemd"
GRUB_CMDLINE_LINUX_DEFAULT="apparmor=1 security=apparmor nvidia-drm.modeset=1" 

*** systemd
ln -sf ../usr/share/zoneinfo/Canada/Mountain /etc/localtime && nano /etc/locale.gen && locale-gen && eselect locale list && eselect locale set 4 && env-update && source /etc/profile && export PS1="(chroot) ${PS1}"

systemd-firstboot --prompt --setup-machine-id && systemctl preset-all && systemctl enable NetworkManager fstrim.timer acpid systemd-timesyncd sysstat apparmor auditd 

power-profiles-daemon nvidia-hibernate.service nvidia-suspend.service nvidia-resume.service nix-daemon

nvim /etc/modprobe.d/nvidia.conf
options nvidia-drm modeset=1 
options nvidia NVreg_UsePageAttributeTable=1


nvim /etc/modprobe.d/nvidia-power-management.conf
options nvidia NVreg_PreserveVideoMemoryAllocations=1 NVreg_TemporaryFilePath=/tmp


** Snapper setup

sudo umount /.snapshots && sudo rm -r /.snapshots && sudo snapper -c root create-config / && sudo btrfs subvolume delete /.snapshots && sudo mkdir /.snapshots && sudo mount -a && sudo chmod 750 /.snapshots && sudo snapper -c root create-config / && sudo nvim /etc/snapper/configs/root && sudo chmod a+rx /.snapshots/ && sudo systemclt enable snapper-timeline.timer snapper-cleanup.timer grub-btrfs.path 

 -- WARNING -- This system is for the use of authorized users only. Individuals 
 using this computer system without authority or in excess of their authority 
 are subject to having all their activities on this system monitored and 
 recorded by system personnel. Anyone using this system expressly consents to 
 such monitoring and is advised that if such monitoring reveals possible 
 evidence of criminal activity system personal may provide the evidence of such 
 monitoring to law enforcement officials.

#scaling apps
--force-device-scale-factor=1.75 %U

#setup snapper
sudo umount /.snapshots/ && sudo rm -r /.snapshots/ && sudo snapper -c root create-config / && sudo btrfs subvolume delete /.snapshots && sudo mkdir /.snapshots && sudo mount -a && sudo chmod 750 /.snapshots && sudo lvim /etc/snapper/configs/root && sudo systemctl enable --now snapper-timeline.timer && sudo systemctl enable --now snapper-cleanup.timer && yay -S snap-pac-grub snapper-gui

sudo lvim /usr/share/gvfs/mounts/network.mount
AutoMount=false

nvim /etc/sysctl.d/harden.conf
kernel.core_pattern=|/bin/false
fs.suid_dumpable=0 
dev.tty.ldisc_autoload=0
fs.protected_fifos=2
fs.protected_regular=2
kernel.kptr_restrict=2
kernel.perf_event_paranoid=3
kernel.sysrq=0
kernel.unprivileged_bpf_disabled=1
kernel.unprivileged_userns_clone=0
net.core.bpf_jit_harden=2
net.ipv4.conf.all.accept_redirects=0
net.ipv4.conf.all.log_martians=1
net.ipv4.conf.all.rp_filter=1
net.ipv4.conf.all.send_redirects=0
net.ipv4.conf.default.accept_redirects=0
net.ipv4.conf.default.log_martians=1
net.ipv6.conf.all.accept_redirects=0
net.ipv6.conf.default.accept_redirects=0



# Post-install chroot
cryptsetup luksOpen /dev/nvme0n1p2 cryptroot && mkdir /mnt/gentoo && mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@ /dev/mapper/cryptroot /mnt/gentoo && mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@home /dev/mapper/cryptroot /mnt/gentoo/home  && mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@opt /dev/mapper/cryptroot /mnt/gentoo/opt && mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@tmp /dev/mapper/cryptroot /mnt/gentoo/tmp && mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@var /dev/mapper/cryptroot /mnt/gentoo/var && mount -o nmoatime,compress=zstd,space_cache=v2,discard=async,subvol=@log /dev/mapper/cryptroot /mnt/gentoo/var/log && mount -o nmoatime,compress=zstd,space_cache=v2,discard=async,subvol=@audit /dev/mapper/cryptroot /mnt/gentoo/var/log/audit && mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@snapshots /dev/mapper/cryptroot /mnt/gentoo/.snapshots && cd /mnt/gentoo && mkdir --parents /mnt/gentoo/etc/portage/repos.conf && cp /mnt/gentoo/usr/share/portage/config/repos.conf /mnt/gentoo/etc/portage/repos.conf/gentoo.conf && cp --dereference /etc/resolv.conf /mnt/gentoo/etc/ && mount --types proc /proc /mnt/gentoo/proc && mount --rbind /sys /mnt/gentoo/sys && mount --make-rslave /mnt/gentoo/sys && mount --rbind /dev /mnt/gentoo/dev && mount --make-rslave /mnt/gentoo/dev && mount --bind /run /mnt/gentoo/run && mount --make-slave /mnt/gentoo/run && test -L /dev/shm && rm /dev/shm && mkdir /dev/shm && mount -t tmpfs -o nosuid,nodev,noexec shm /dev/shm && chmod 1777 /dev/shm

chroot /mnt/gentoo /bin/bash
source /etc/profile
export PS1="(chroot) ${PS1}"


