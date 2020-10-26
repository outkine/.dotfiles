# base: https://wiki.archlinux.org/index.php/Installation_guide
# make sure to run this in an up-to-date Arch ISO! don't be lazy!


### IN ARCH ISO

iwctl
> station [INTERFACE] connect [SSID]

# fdisk

mkfs.fat -F32 /dev/[EFI] # if necessary
mkfs.ext4 /dev/[PRIMARY]
mkswap /dev/[SWAP]
swapon /dev/[SWAP]
mount /dev/[PRIMARY] /mnt
mkdir /mnt/boot
mount /dev/[EFI] /mnt/boot
timedatectl set-ntp true

pacman-key --refresh-keys # run this if old ISO

pacman -Sy pacman-contrib neovim grub efibootmgr # if dual boot: os-prober

cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.orig
rankmirrors /etc/pacman.d/mirrorlist.orig > /etc/pacman.d/mirrorlist
pacstrap /mnt base base-devel

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt


# IN ARCH ISO CHROOT

pacman -S networkmanager linux-firmware # for wifi and wifi drivers

ln -sf /usr/share/zoneinfo/US/Central /etc/localtime
hwclock --systohc

nvim /etc/locale.gen
# uncomment en_US.UTF-8 UTF-8
# uncomment ru_RU.UTF-8 UTF-8
locale-gen
cat "LANG=en_US.UTF-8" > /etc/local.conf
cat [HOSTNAME] > /etc/hostname

passwd

grub-install --target=x86_64-efi --efi-directory=/boot
curl https://pastebin.com/raw/i74S7WHp >> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

sudo mkinitcpio -p linux

exit
umount -R /mnt
shutdown now -r


# IN NEW OS
systemctl enable NetworkManager --now
nmcli d wifi connect [SSID] password [PASSWORD]

useradd -m [user]
passwd [user]
gpasswd -a [user] adm
gpasswd -a [user] wheel
pacman -S vi # may be necessary
visudo
# uncomment the %wheel line that allows for no password sudo
exit

# login as [USER]
sudo pacman -S git
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

git config --global credential.helper store


# on old:
# pacman -Qqen > pkglist.txt
# and
# pacman -Qqem > extpkglist.txt
sudo pacman -S --needed $(comm -12 <(pacman -Slq|sort) <(sort pkglist.txt) )
yay -S --noedit --noconfirm --needed $(cat extpkglist.txt)

ssh-keygen
sudo chsh -s /bin/zsh
sudo lux
systemctl --user enable redshift
pip3 install --user neovim

sudo systemctl enable org.cups.cupsd
sudo systemctl enable lightdm
sudo systemctl enable tlp
sudo gpasswd -a anton bumblebee
sudo systemctl enable bumblebeed
sudo systemctl enable NetworkManager

shutdown now -r


### DOTFILE MANAGEMENT
# from https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
echo ".cfg" >> .gitignore
git clone --bare https://github.com/outkine/.dotfiles $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config checkout --force
config config --local status.showUntrackedFiles no
xrdb .Xresources


### HIDE FIREFOX BAR
# .mozilla/firefox/.../chrome/userChrome.css
"""
#sidebar-box[sidebarcommand="treestyletab_piro_sakura_ne_jp-sidebar-action"] #sidebar-header {
  display: none;
}
"""


### HIDE SPOTIFY NOTIFICATIONS
# .config/spotify/Users/.../prefs
"""
ui.track_notifications_enabled=false
"""


### MOZILLA FILES
# on old: copy .mozilla and thunderbird over usb
# sudo mount /dev/sd[x] /mnt
# sudo tar czf /mnt/thunderbird.tar.gz ~/.thunderbird
# sudo tar czf /mnt/mozilla.tar.gz ~/.mozilla
rm -rf ~/.mozilla
sudo tar xzf /mnt/mozilla.tar.gz > ~/.mozilla
rm -rf ~/.thunderbird
sudo tar xzf /mnt/thunderbird.tar.gz > ~/.thunderbird


### CRON
# system suspend
sudo crontab -e
# 0 * * * * /bin/systemctl suspend

# user notification
crontab -e
# 55 * * * * eval "export $(egrep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep -u $LOGNAME gnome-session)/environ)"; XDG_RUNTIME_DIR=/run/user/$(id -u) DISPLAY=:0 /usr/bin/notify-send "SLEEPING SOON"


### OTHER FILES
sudo curl https://pastebin.com/raw/GuvCxGek > /etc/X11/xorg.conf.d/20-intel.conf
sudo curl https://pastebin.com/KXbNYPSm >  /etc/X11/xorg.conf.d/30-touchpad.conf
sudo curl https://pastebin.com/5A3iCNCC > /etc/systemd/logind.conf


### FONTS
# https://web.archive.org/web/20190219192810if_/https://www.reddit.com/r/archlinux/comments/5r5ep8/make_your_arch_fonts_beautiful_easily/
sudo pacman -S ttf-dejavu ttf-liberation noto-fonts
sudo ln -s /etc/fonts/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d
sudo ln -s /etc/fonts/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d
sudo ln -s /etc/fonts/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d

# Enable FreeType subpixel hinting mode by editing:
sudo nvim /etc/profile.d/freetype2.sh
# Uncomment the desired mode at the end:
# export FREETYPE_PROPERTIES="truetype:interpreter-version=40"

sudo curl https://pastebin.com/raw/Dc9U71gX > /etc/fonts/local.conf


### ALSO COPY: ZSH HISTORY
