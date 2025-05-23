# Dotfiles and configuration files for NixOS

Forked from Jerry - https://github.com/JerrySM64/dotfiles 

# Some copy paste for my usage

- git clone https://github.com/TomekBobrowicz/nixfiles
- sudo nixos-generate-config --show-hardware-config > nixfiles/nixos/hosts/<hostname>/hardware.nix
- NIX_CONFIG="experimental-features = nix-command flakes" 
- sudo nixos-rebuild switch --flake .#hostname


## Thinkpad minimal installation

# Wipe both disks
wipefs -a /dev/nvme0n1
wipefs -a /dev/nvme1n1

# Create GPT partition tables
parted /dev/nvme0n1 -- mklabel gpt
parted /dev/nvme0n1 -- mkpart primary fat32 1MiB 1024MiB
parted /dev/nvme0n1 -- set 1 esp on
parted /dev/nvme0n1 -- mkpart primary 1024MiB 100%

parted /dev/nvme1n1 -- mklabel gpt
parted /dev/nvme1n1 -- mkpart primary 1MiB 100%

# Create physical volumes
pvcreate /dev/nvme0n1p2 /dev/nvme1n1p1

# Create volume group
vgcreate vg /dev/nvme0n1p2 /dev/nvme1n1p1

# Create logical volumes
lvcreate -L 8G -n swap vg
lvcreate -L 100G -n root vg
lvcreate -l 100%FREE -n home vg

# Format EFI partition
mkfs.fat -F 32 /dev/nvme0n1p1

# Format root
mkfs.btrfs /dev/vg/root

# Format home
mkfs.btrfs /dev/vg/home

# Setup swap
mkswap /dev/vg/swap

# Mount
mount /dev/vg/root /mnt
mkdir /mnt/boot
mount /dev/nvme0n1p1 /mnt/boot
swapon /dev/vg/swap
mkdir /mnt/home
mount /dev/vg/home /mnt/home

nixos-generate-config --root /mnt
nixos-install
reboot

