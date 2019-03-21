# supplements: https://wiki.archlinux.org/index.php/Installation_guide
# make sure to run this in an up-to-date Arch ISO!

wifi-menu
timedatectl set-ntp true
mkfs.ext4 /dev/nvme0n1p4 mkswap /dev/nvme0n1p5 swapon /dev/nvme0n1p5
mount /dev/nvme0n1p4 /mnt
mkdir /mnt/boot
mount /dev/nvme0n1p1 /mnt/boot

# run this if old ISO
pacman-key --refresh-keys

pacman -Sy pacman-contrib neovim grub efibootmgr os-prober iw wpa_supplicant dialog

cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.orig
rankmirrors /etc/pacman.d/mirrorlist.orig > /etc/pacman.d/mirrorlist
pacstrap /mnt base base-devel
genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt
ln -sf /usr/share/zoneinfo/US/Central /etc/localtime
hwclock --systohc

nvim /etc/locale.gen
# uncomment en_US.UTF-8 UTF-8
# uncomment ru_RU.UTF-8 UTF-8
locale-gen
cat "LANG=en_US.UTF-8" > /etc/local.conf
cat "useless-box" > /etc/hostname
passwd

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub
curl pastebin.com/raw/i74S7WHp >> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
sudo mkinitcpio -p linux

exit
reboot

useradd -m anton
passwd anton
gpasswd -a anton adm
gpasswd -a anton wheel
visudo
# uncomment the %wheel line that allows for no password sudo
exit

# login as anton
sudo pacman -S git
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

yay -S
  \xorg lightdm lightdm-gtk-greeter
  \i3 rxvt-unicode-truecolor zsh dunst polybar rofi
  \tlp powertop htop
  \bumblebee bbswitch nvidia mesa mesa-demos xf86-video-intel
  \thunderbird firefox telegram-desktop gthumb inkscape gimp gthumb libreoffice-fresh figma-bin
  \redshift playerctl unzip fasd imagemagick scrot hub openssh xclip ncdu emojione-picker-git timew httpie
  \lxappearance paper-icon-theme arc-gtk-theme
  \networkmanager nm-applet gnome
  \lux pulseaudio pulseaudio-alsa alsa-utils
  \ttf-roboto-mono-powerline-git
  \cups
sudo chsh -s /bin/zsh
sudo systemctl enable org.cups.cupsd
sudo systemctl enable lightdm
sudo systemctl enable tlp
sudo gpasswd -a anton bumblebee
sudo systemctl enable bumblebeed
sudo systemctl enable NetworkManager
systemctl --user enable redshift

shutdown now -r

ssh-keygen

git config --global credential.helper store

git clone https://github.com/asdf-vm/asdf.git ~/.asdf
cd ~/.asdf
git checkout "$(git describe --abbrev=0 --tags)"
asdf plugin-add python
asdf plugin-add node
asdf plugin-add elixir
asdf install python 3.7.2
asdf global python 3.7.2
# and so on
mix archive.install hex phx_new 1.4.2

pip3 install --user neovim

# from https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
echo ".cfg" >> .gitignore
git clone --bare https://github.com/outkine/.dotfiles $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config checkout


# .mozilla/firefox/.../chrome/userChrome.css
"""
#sidebar-box[sidebarcommand="treestyletab_piro_sakura_ne_jp-sidebar-action"] #sidebar-header {
  display: none;
}
"""

# .config/spotify/Users/.../prefs
"""
ui.track_notifications_enabled=false
"""

# and then copy .mozilla and thunderbird over usb
# sudo mount /dev/sd... /mnt
# sudo tar czf /mnt/thunderbird.tar.gz ~/.thunderbird
# sudo tar czf /mnt/mozilla.tar.gz ~/.mozilla
# THEN
# rm -rf ~/.mozilla
# sudo tar xzf /mnt/mozilla.tar.gz > ~/.mozilla
# rm -rf ~/.thunderbird
# sudo tar xzf /mnt/thunderbird.tar.gz > ~/.thunderbird
