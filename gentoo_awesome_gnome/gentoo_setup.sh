*** BTRFS
cfdisk /dev/nvme0n1 && cryptsetup -c aes-xts-plain64 -s 512 -y luksFormat /dev/nvme0n1p2 && cryptsetup luksOpen /dev/nvme0n1p2 cryptroot && mkfs.btrfs /dev/mapper/cryptroot && mkdir /mnt/gentoo && mount /dev/mapper/cryptroot /mnt/gentoo 

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
COMMON_FLAGS="-march=native -O3 -pipe"
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
USE="-elogind systemd -gnome -berkdb  -kde -ccache zstd policykit qt5 \
      clamav -coreaudio -ios -ipod -ieee1394 -motif gtk pulseaudio \
      -emboss -3dfx -altivec smartcard -ibm -wayland -nls -nas pam networkmanager\
      -neon -nntp -cups -quicktime nvidia sound-server -vim apparmor gtk4 \
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

=app-backup/grub-btrfs-9999 ** ~amd64
=x11-misc/picom-9999 ** ~amd64
=x11-wm/awesome-9999 ** ~amd64
app-eselect/eselect-repository ~amd64
dev-vcs/git ~amd64
sys-devel/gcc ~amd64
sci-libs/tensorflow ~amd64
sys-apps/xdg-desktop-portal-gnome ~amd64
sys-apps/xdg-desktop-portal ~amd64
sec-policy/apparmor-profiles ~amd64
sys-fs/squashfs-tools ~amd64
dev-libs/inih ~amd64
dev-libs/userspace-rcu ~amd64
sys-apps/apparmor ~amd64
sys-fs/xfsprogs ~amd64
app-containers/snapd ~amd64
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
app-admin/sudo ~amd64 
app-text/zathura ~amd64
app-text/zathura-meta ~amd64
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
gnome-base/gvfs ~amd64
x11-libs/libX11 ~amd64
x11-libs/libXinerama ~amd64
x11-libs/libXft ~amd64
media-libs/freetype ~amd64
media-gfx/feh ~amd64
x11-misc/rofi ~amd64
media-gfx/flameshot ~amd64
x11-misc/xsel ~amd64
x11-misc/xclip ~amd64
x11-apps/xsetroot ~amd64
x11-base/xorg-server ~amd64
x11-base/xorg-drivers ~amd64
x11-drivers/nvidia-drivers ~amd64
x11-apps/mesa-progs ~amd64 
app-forensics/aide ~amd64
sys-apps/rng-tools ~amd64
sys-apps/haveged ~amd64
dev-lang/luajit ~amd64
app-forensics/lynis ~amd64
sys-apps/firejail ~amd64
sys-process/audit ~amd64
app-admin/sysstat ~amd64
sys-apps/apparmor ~amd64
sys-apps/apparmor-utils ~amd64 
sys-libs/libapparmor ~amd64
sec-policy/apparmor-profiles ~amd64
sys-process/acct ~amd64 
app-backup/snapper ~amd64
sys-boot/grub ~amd64
app-admin/sysklogd ~amd64
sys-apps/mlocate ~amd64
app-misc/fdupes ~amd64
sys-power/acpi ~amd64
app-misc/tmux ~amd64 
app-admin/keepassxc ~amd64
www-client/brave-bin ~amd64

rm -R /mnt/gentoo/etc/portage/package.use && nano -w /mnt/gentoo/etc/portage/package.use
*/* LUA_SINGLE_TARGET: luajit -lua5-1
*/* PYTHON_SINGLE_TARGET: python3_11 -python3_10 -python3_12
x11-wm/awesome dbus gnome 
app-editors/neovim lto
net-libs/nodejs lto npm 
dev-lang/rust clippy miri nightly rust-analyzer rustfmt system-llvm rust-src
net-p2p/transmission gtk -qt5 -qt6
sys-config/ltoize keep-nocommon clang
sys-fs/squashfs-tools xattr zstd lz4 lzma lzo
dev-util/cmake -emacs ncurses -qt5
media-fonts/iosevka X iosevka-aile
app-text/xmlto text
gnome-base/gvfs udisks
dev-lang/luajit lua52compat
dev-libs/libdbusmenu gtk3
app-crypt/gcr gtk
sys-apps/kmod zstd
sys-boot/grub:2 device-mapper
app-admin/sysstat lto lm-sensors
sys-libs/zlib minizip
app-text/poppler cairo
dev-lang/python lto pgo ensurepip tk hardened
sys-devel/gcc lto pgo graphite jit default-stack-clash-protection rustc
sys-apps/firejail apparmor private-home
app-editors/emacs alsa dynamic-loading gfile gmp gtk gui gzip-el harfbuzz imagemagick inotify jit jpeg motif png ssl svg threads tiff tree-sitter zlib 
app-text/ghostscript-gpl cups
dev-python/PyQt5 widgets
media-sound/pulseaudio -daemon
media-video/pipewire sound-server
sys-apps/kmod tools
sys-apps/systemd policykit
media-sound/mpg123 -pulseaudio
media-libs/libpng apng
sys-libs/gdbm berkdb
dev-libs/boost context
dev-libs/boehm-gc cxx
virtual/libcrypt static-libs
sys-libs/libxcrypt static-libs
media-fonts/nerd-fonts jetbrainsmono firacode
gui-libs/gtk-layer-shell introspection
net-wireless/wpa_supplicant dbus
net-libs/libssh server
sys-config/ltoize clang
sys-apps/flatpak policykit seccomp
app-admin/keepassxc browser autotype keeshare network yubikey
app-office/libreoffice branding googledrive gtk gstreamer
dev-libs/boost nls
dev-libs/xmlsec nss
net-analyzer/snort threads
app-portage/eix optimization strong-security tools
app-misc/fdupes ncurses
dev-libs/libpcre2 pcre32
x11-base/xorg-server xcsecurity xorg


rm -R /mnt/gentoo/etc/portage/package.mask && nano -w /mnt/gentoo/etc/portage/package.mask

>=dev-lang/python-12
x11-libs/gtk+::mv
>=sys-devel/gcc-13
>=sys-kernel/gentoo-sources-6.2

* setup fstab and chroot

mount /dev/nvme0n1p1 /mnt/gentoo/boot && genfstab -U /mnt/gentoo >> /mnt/gentoo/etc/fstab && mkdir --parents /mnt/gentoo/etc/portage/repos.conf && cp /mnt/gentoo/usr/share/portage/config/repos.conf /mnt/gentoo/etc/portage/repos.conf/gentoo.conf && cp --dereference /etc/resolv.conf /mnt/gentoo/etc/ && mount --types proc /proc /mnt/gentoo/proc && mount --rbind /sys /mnt/gentoo/sys && mount --make-rslave /mnt/gentoo/sys && mount --rbind /dev /mnt/gentoo/dev && mount --make-rslave /mnt/gentoo/dev && mount --bind /run /mnt/gentoo/run && mount --make-slave /mnt/gentoo/run && test -L /dev/shm && rm /dev/shm && mkdir /dev/shm && mount -t tmpfs -o nosuid,nodev,noexec shm /dev/shm && chmod 1777 /dev/shm

* chroot-into
chroot /mnt/gentoo /bin/bash
source /etc/profile
export PS1="(chroot) ${PS1}"

emerge-webrsync && emerge --sync --quiet && emerge app-eselect/eselect-repository dev-vcs/git 

* switch portage to git
eselect repository remove gentoo && eselect repository add gentoo git https://github.com/gentoo-mirror/gentoo.git  && emaint sync -r gentoo && eselect repository enable guru lto-overlay mv brave-overlay && emaint sync -r guru && emaint sync -r lto-overlay && emaint sync -r mv && emaint sync -r brave-overlay 

* lto setup
emerge -av ltoize lto-rebuild && lto-rebuild -r

* gcc upgrade
emerge -aq sys-devel/gcc && lto-rebuild -r && gcc-config --list-profiles && emerge --ask --oneshot --usepkg=n sys-devel/libtool && emerge  -eq --usepkg=n @system && emerge -eq --usepkg=n @world


* gcc downgrade
revdep-rebuild --library 'libstdc++.so.6' -- --exclude gcc && emerge --ask --oneshot --usepkg=n --verbose sys-devel/libtool
 
* initial-packages
emerge --sync && emerge -auvDN @world

* kernel setup
emerge -aq sys-kernel/gentoo-sources sys-kernel/linux-firmware sys-kernel/linux-headers sys-kernel/genkernel sys-apps/fwupd sys-fs/cryptsetup sys-firmware/intel-microcode && eselect kernel set 1 && ls -l /usr/src/linux 
  
genkernel --luks --menuconfig --install all

** miscellenous apps
emerge -aq app-arch/unzip app-arch/zip app-arch/unrar sys-fs/btrfs-progs sys-fs/dosfstools net-misc/wget net-misc/curl app-misc/neofetch app-misc/ckb dev-python/pynvim app-editors/neovim sys-apps/ripgrep sys-apps/fd app-shells/zsh app-shells/zsh-completions app-shells/gentoo-zsh-completions app-shells/zoxide dev-util/fnm app-shells/fzf sys-fs/fuse:0 sys-apps/flatpak dev-vcs/lazygit x11-apps/xsetroot x11-base/xorg-server x11-base/xorg-drivers x11-drivers/nvidia-drivers x11-apps/mesa-progs app-forensics/aide sys-apps/rng-tools sys-apps/haveged app-forensics/lynis sys-apps/firejail app-admin/sysstat sys-apps/apparmor sys-apps/apparmor-utils sys-libs/libapparmor sec-policy/apparmor-profiles sys-process/acct app-backup/snapper app-backup/grub-btrfs sys-boot/grub sys-apps/mlocate app-misc/tmux app-admin/keepassxc www-client/brave-bin x11-terms/kitty x11-misc/rofi sys-power/acpi sys-power/acpid sys-power/acpi_call sys-power/upower app-misc/jq sys-fs/inotify-tools gnome-extra/polkit-gnome x11-misc/xdotool x11-misc/xsel x11-misc/xclip media-video/ffmpeg media-sound/alsa-utils media-gfx/feh media-gfx/flameshot media-libs/mutagen x11-wm/awesome dev-lua/luarocks 

passwd && useradd -m -G users,wheel,audio,video -s /bin/bash ahsan && passwd ahsan && EDITOR=nvim visudo

grub-install --target=x86_64-efi --efi-directory=/boot && grub-install --target=x86_64-efi --efi-directory=/boot --removable && grub-mkconfig -o /boot/grub/grub.cfg

nvim /etc/default/grub
GRUB_CMDLINE_LINUX="quiet crypt_root=UUID=45832874-d38f-493b-9f85-437809b0e67a root_trim=yes init=/lib/systemd/systemd"
GRUB_CMDLINE_LINUX_DEFAULT="apparmor=1 security=apparmor" 

*** systemd
ln -sf ../usr/share/zoneinfo/Canada/Mountain /etc/localtime && nano /etc/locale.gen && locale-gen && eselect locale list && eselect locale set 4 && env-update && source /etc/profile && export PS1="(chroot) ${PS1}"

systemd-firstboot --prompt --setup-machine-id && systemctl enable NetworkManager fstrim.timer acpid systemd-timesyncd sysstat apparmor auditd 

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

#ivpn installation

  install -Dm755 -g root -o root References/Linux/scripts/_out_bin/ivpn-service "/usr/bin/ivpn-service" && install -Dm700 -g root -o root References/Linux/etc/client.down "/opt/ivpn/etc/client.down" && install -Dm700 -g root -o root References/Linux/etc/client.up "/opt/ivpn/etc/client.up" && install -Dm700 -g root -o root References/Linux/etc/firewall.sh "/opt/ivpn/etc/firewall.sh" && install -Dm700 -g root -o root References/Linux/etc/splittun.sh "/opt/ivpn/etc/splittun.sh" && install -Dm600 -g root -o root References/common/etc/servers.json "/opt/ivpn/etc/servers.json" && install -Dm400 -g root -o root References/common/etc/ca.crt "/opt/ivpn/etc/ca.crt" && install -Dm400 -g root -o root References/common/etc/ta.key "/opt/ivpn/etc/ta.key" && install -Dm755 -g root -o root References/Linux/_deps/wireguard-tools_inst/wg-quick "/opt/ivpn/wireguard-tools/wg-quick" && install -Dm755 -g root -o root References/Linux/_deps/wireguard-tools_inst/wg "/opt/ivpn/wireguard-tools/wg" && install -Dm755 -g root -o root References/Linux/_deps/obfs4proxy_inst/obfs4proxy "$pkgdir/opt/ivpn/obfsproxy/obfs4proxy" && install -Dm755 -g root -o root References/Linux/_deps/dnscryptproxy_inst/dnscrypt-proxy "/opt/ivpn/dnscrypt-proxy/dnscrypt-proxy" && install -Dm400 -g root -o root References/common/etc/dnscrypt-proxy-template.toml "/opt/ivpn/etc/dnscrypt-proxy-template.toml"

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


# Emacs packages
use-package no-littering general which-key evil-surround evil-commentary evil-quickscope evil-numbers evil-lion avy ace-link transpose-frame smartparens expand-region visual-fill-column projectile counsel-projectile magit forge git-gutter git-timemachine editorconfig deadgrep counsel swiper ivy-rich ivy-prescient helpful wakatime-mode request activity-watch-mode olivetti keycast doom-themes auto-dim-other-buffers ligature all-the-icons highlight-indent-guides rainbow-delimiters rainbow-mode hl-todo doom-modeline perspective treemacs lsp-mode lsp-treemacs flycheck tree-sitter tree-sitter-langs dap-mode copilot emmet-mode prettier  typescript-mode app-emacs/tex markdown-mode plantuml-mode subed langtool lispy lispyville hy-mode ein jedhy lsp-pyright yapf  yapfify black isort py-isort sphinx-doc pytest  code-cells  json-mode csv-mode yaml-mode dotenv-mode gitignore-templates dockerfile-mode jenkinsfile-mode crontab-mode doc-view org org-contrib  evil-org app-emacs/jupyter ob-hy f  restclient ob-restclient ob-jupyter ob-async org-present hide-mode-line org-make-toc org-attach-screenshot org-transclusion edraw-org


# Sample Systemd Service
[Unit]
Description=

[Service]
ExecStart=

[Install]
WantedBy=multi-user.target    


 
# Post-install chroot
cryptsetup luksOpen /dev/nvme0n1p2 cryptroot && mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@ /dev/mapper/cryptroot /mnt/gentoo && mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@home /dev/mapper/cryptroot /mnt/gentoo/home  && mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@opt /dev/mapper/cryptroot /mnt/gentoo/opt && mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@tmp /dev/mapper/cryptroot /mnt/gentoo/tmp && mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@var /dev/mapper/cryptroot /mnt/gentoo/var && mount -o nmoatime,compress=zstd,space_cache=v2,discard=async,subvol=@log /dev/mapper/cryptroot /mnt/gentoo/var/log && mount -o nmoatime,compress=zstd,space_cache=v2,discard=async,subvol=@audit /dev/mapper/cryptroot /mnt/gentoo/var/log/audit && mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@snapshots /dev/mapper/cryptroot /mnt/gentoo/.snapshots && cd /mnt/gentoo && mkdir --parents /mnt/gentoo/etc/portage/repos.conf && cp /mnt/gentoo/usr/share/portage/config/repos.conf /mnt/gentoo/etc/portage/repos.conf/gentoo.conf && cp --dereference /etc/resolv.conf /mnt/gentoo/etc/ && mount --types proc /proc /mnt/gentoo/proc && mount --rbind /sys /mnt/gentoo/sys && mount --make-rslave /mnt/gentoo/sys && mount --rbind /dev /mnt/gentoo/dev && mount --make-rslave /mnt/gentoo/dev && mount --bind /run /mnt/gentoo/run && mount --make-slave /mnt/gentoo/run && test -L /dev/shm && rm /dev/shm && mkdir /dev/shm && mount -t tmpfs -o nosuid,nodev,noexec shm /dev/shm && chmod 1777 /dev/shm

chroot /mnt/gentoo /bin/bash
source /etc/profile
export PS1="(chroot) ${PS1}"


