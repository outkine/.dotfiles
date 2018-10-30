wifi-menu
timedatectl set-ntp true
mkfs.ext4 /dev/nvme0n1p4
mkswap /dev/nvme0n1p5
swapon /dev/nvme0n1p5
mount /dev/nvme0n1p4 /mnt
mkdir /mnt/boot
mount /dev/nvme0n1p1 /mnt/boot
cp /etc/pacman.d/mirrorlist > /etc/pacman.d/mirrorlist.orig
rankmirrors /etc/pacman.d/mirrorlist.orig > /etc/pacman.d/mirrorlist
pacstrap /mnt base base-devel
genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt
(uncomment en_US.UTF-8 UTF-8)
(uncomment ru_RU.UTF-8 UTF-8)
locale-gen
(add LANG=en_US.UTF-8 to /etc/locale.conf)
set hosts
hostnamectl set-hostname
passwd

pacman -S grub efibootmgr os-prober

grub-install --target=x86_64-efi --efi-directory=/boot--bootloader-id=grub
sudo curl https://pastebin.com/raw/i74S7WHp >> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

pacman -S grub iw wpa_supplicant dialog

exit
reboot

useradd -m anton
passwd anton
gpasswd -a anton adm
gpasswd -a anton wheel
visudo (uncomment the %wheel line)
exit


sudo pacman -S xorg i3
.xinitrc = exec i3
startx

run https://gist.github.com/Tadly/0e65d30f279a34c33e9b
https://www.reddit.com/r/archlinux/comments/5r5ep8/make_your_arch_fonts_beautiful_easily/
sudo ln -s /etc/fonts/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d
sudo ln -s /etc/fonts/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d
sudo ln -s /etc/fonts/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d
in /etc/profile.d/freetype2.sh
export FREETYPE_PROPERTIES="truetype:interpreter-version=40"
make /etc/fonts/local.conf

gpg --recv-keys 8F0871F202119294 D1483FA6C3C07136
pacaur -S --noconfirm nitrogen xautolock dunst redshift rofi spotify discord visual-studio-code-bin imagemagick gimp inkscape lxappearance paper-icon-theme arc-gtk-theme scrot zsh tlp powertop bumblebee bbswitch wpa_actiond alsa-utils feh ttf-material-design-icons-git polybar ranger htop powerline-fonts-git pulseaudio  pulseaudio-alsa xss-lock tor-browser playerctl noto-fonts-emoji cups avahi nss-mdns xorg-xrandr libreoffice-fresh gthumb unzip fuse2 transmission-gtk ttf-noto-fonts-simple ufw
https://pastebin.com/raw/Xi3e4pkK

pacaur -S --noconfirm --needed redshift spotify discord visual-studio-code-bin gimp inkscape paper-icon-theme arc-gtk-theme zsh tlp powertop bumblebee bbswitch powerline-fonts-git tor-browser libreoffice-fresh gthumb transmission-gtk ttf-noto-fonts-simple ufw system-config-printer ttf-symbola file-roller gravit-designer-bin love


yaourt -S --noconfirm redshift rofi spotify discord visual-studio-code-bin gimp inkscape paper-icon-theme arc-gtk-theme bumblebee bbswitch wpa_actiond powerline-fonts-git tor-browser vim emacs urxvt watchman wget

#broken: spotify, gravit-designer-bin

sudo systemctl enable org.cups.cupsd.service
sudo systemctl enable avahi-daemon.service
sudo systemctl enable cups-browsed.service
add mdns_minimal [NOTFOUND=return]  to /etc/nsswitch.conf4

sudo systemctl disable netctl
sudo systemctl enable netctl-auto@wlp2s0


sudo systemctl enable tlp

gpasswd -a anton bumblebee
sudo systemctl enable bumblebee

modify /usr/systemd/logind.conf
modify /etc/mkinitcpio.conf HOOKS="base udev resume autodetect modconf block filesystems keyboard fsck"

sudo mkinitcpio -p linux

tlp usb
/etc/default/tlp
RUNTIME_PM_BLACKLIST="1:00.0"
DEVICES_TO_DISABLE_ON_STARTUP="bluetooth wwan"

chsh -s /bin/zsh
cd $ZPREZTODIR
git pull
git submodule update --init --recursive

cat << EOF | sudo tee /etc/systemd/system/powertop.service
[Unit]
Description=PowerTOP auto tune

[Service]
Type=idle
Environment="TERM=dumb"
ExecStart=/usr/sbin/powertop --auto-tune

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable powertop.service

setxkbmap -layout "us,ru"
setxkbmap -option 'grp:alt_shift_toggle'

# react native
pacaur -S watchman
echo fs.inotify.max_user_watches=524288 | sudo tee /etc/sysctl.d/40-max-user-watches.conf && sudo sysctl --system

git config --global credential.helper store

/etc/X11/xorg.conf.d/30-touchpad.conf needs to be —>
Section "InputClass"
	Identifier "libinput touchpad catchall"
	MatchIsTouchpad "on"
	MatchDevicePath "/dev/input/event*"
	Option "Tapping" "on"
	Driver "libinput"
EndSection

git config credential.helper store

chsh -s /bin/zsh

dconf dump /org/cinnamon/ > cinnamon.dconf
dconf dump /org/nemo/ > nemo.dconf
dconf dump /org/gtk/ > gtk.dconf
dconf dump /org/gnome/ > gnome.dconf



LOAD PROCESS

dconf load /org/cinnamon/ < cinnamon.dconf
dconf load /org/nemo/ < nemo.dconf
dconf load /org/gtk/ < gtk.dconf
dconf load /org/gnome/ < gnome.dconf

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash


echo fs.inotify.max_user_watches=524288 | sudo tee /etc/sysctl.d/40-max-user-watches.conf && sudo sysctl --system


pacman -S nvidia

HandlePowerKey=ignore
HandleLidSwitch=hybrid-sleep
/etc/systemd/logind.conf

https://wiki.archlinux.org/index.php/redshift#configuration
