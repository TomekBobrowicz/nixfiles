{ config, pkgs, inputs, outputs, ... }:

{
  imports = [
     ./hardware.nix
   #  ../../de/gnome.nix
   #  ../../de/kde.nix
   #  ../../de/xfce.nix
   #  ../../wm/awesomewm.nix
     ../../wm/hyprland.nix
   #  ../../wm/qtile.nix
   #  ../../wm/wayfire.nix
     ../../../pkgs/dev.nix
     ../../../pkgs/fonts.nix
     ../../../pkgs/system.nix
     ../../../pkgs/hosts/thinkpad/system.nix
    # Import home-manager's NixOS module
    inputs.home-manager.nixosModules.home-manager
  ];

  boot = {
    # Use Zen Kernel
    kernelPackages = pkgs.linuxPackages_zen;

    # Kernel parameters
    kernelParams = [
    ];

    # Specify the kernel modules to blacklist
    blacklistedKernelModules = [
    ];
  # Enable Plymouth
      plymouth.enable = true; 
  };

  # Hostname
  networking = {
    hostName = "thinkpad";
  };

  # Hardware support
  hardware = {
    # Bluetooth
    bluetooth = {
      enable = true;
    };
  };

  # Man, I love services. I want some more!
  services = {
    pipewire = {
      jack = {
        enable = true;
      };
    };
  };

  # QEMU/KVM & Podman
  virtualisation = {
    # Podman for containers
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork = {
        settings = {
          dns_enabled = true;
        };
      };
    };
  };

  # Environment related things
  environment = {
    sessionVariables = {
      LIBVIRT_DEFAULT_URI = [
      ];
    };
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      # Import your home-manager configuration
      buber = import ../../../home-manager/hosts/thinkpad/default.nix;
    };
  };
}
