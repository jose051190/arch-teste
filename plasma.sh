#!/bin/bash

# Função para verificar o status dos comandos
check_command() {
  if [ $? -ne 0 ]; then
    echo "Erro ao executar: $1"
    exit 1
  fi
}

# Instalar Plasma e pacotes adicionais sem confirmação
sudo pacman -S --needed --noconfirm plasma-meta plasma-workspace konsole okular sddm xorg filelight ffmpeg ffmpegthumbs ffmpegthumbnailer nextcloud-client ttf-nerd-fonts-symbols elisa gwenview plymouth kwayland kwayland-integration konsole kwrite packagekit-qt6 ark egl-wayland dolphin dolphin-plugins xdg-desktop-portal-kde okular spectacle partitionmanager qt6-multimedia qt6-multimedia-gstreamer qt6-multimedia-ffmpeg qt6-wayland kdeplasma-addons kcalc plasma-systemmonitor kdeconnect kio-gdrive lokalize kde-dev-utils kompare ghostwriter knotes kclock timeshift neovim firefox-i18n-pt-br gparted plasma-firewall ttf-fira-sans ttf-roboto-mono-nerd ttf-fira-mono rclone telegram-desktop ufw fastfetch neofetch htop ncdu qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat dmidecode libguestfs steam lutris wine-staging goverlay pycharm-community-edition ufw
check_command "pacman -S plasma-desktop e outros pacotes"

# Configurar GRUB para Plymouth
sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="/&splash rd.udev.log_priority=3 vt.global_cursor_default=0 nvidia_drm.modeset=1 nvidia.NVreg_EnableGpuFirmware=0 /' /etc/default/grub
check_command "sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=\"/&splash rd.udev.log_priority=3 vt.global_cursor_default=0 nvidia_drm.modeset=1 nvidia.NVreg_EnableGpuFirmware=0 /' /etc/default/grub"

# Atualizar GRUB
sudo grub-mkconfig -o /boot/grub/grub.cfg
check_command "sudo grub-mkconfig -o /boot/grub/grub.cfg"

# Adicionar plymouth ao vetor HOOKS em mkinitcpio.conf após base e udev
sudo sed -i '/^HOOKS=/ s/\(base udev\)/\1 plymouth/' /etc/mkinitcpio.conf
check_command "sudo sed -i '/^HOOKS=/ s/\(base udev\)/\1 plymouth/' /etc/mkinitcpio.conf"

# Atualizar mkinitcpio
sudo mkinitcpio -p linux
check_command "sudo mkinitcpio -p linux"

# Ativação e início do serviço libvirtd
sudo systemctl enable --now libvirtd.service