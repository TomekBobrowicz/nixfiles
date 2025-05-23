{ config, pkgs, ... }:

{
  config = {
    programs = {
      # Enable Z-Shell
      zsh = {
        enable = true;

        # Syntax Highlighting
        syntaxHighlighting = {
          enable = true;
        };

        # Autosuggestions
        autosuggestions = {
          enable = true;
          async = true;
          highlightStyle = "fg=cyan";
          strategy = ["completion"];
        };

        # Oh my Zsh
        ohMyZsh = {
          enable = true;
          plugins = [
            "history-substring-search"
            "systemd"
          ];
        };
      };

      # Bye bye, Nano!
      nano = {
        enable = false;
      };

      # Firefox
      firefox = {
        enable = true;
        package = pkgs.firefox-wayland;
      };

      # SUID wrapper
      mtr = {
        enable = true;
      };

      gnupg = {
        agent = {
          enable = true;
          enableSSHSupport = true;
        };
      };
    };


    # Define the system packages here
    environment = {
      systemPackages = with pkgs; [
        brave
        btop
        discord
        eza
        fastfetch
        google-chrome
        kitty
        lm_sensors
        neovim
        nextcloud-client
        networkmanagerapplet
        nh
        ntfs3g
        nwg-look
        pciutils
        pfetch
        pkgs.sddm-astronaut
        protonvpn-gui
        starship
        tdesktop
        unzip
        vlc
        wget
      ];
    };
  };
}
