{ config, pkgs, inputs, system, security, ... }: 
  
{
  config = {
    services = {
      displayManager.sddm = {
        enable = true;
        wayland = {
         enable = true;
       };
       package = pkgs.kdePackages.sddm;
       extraPackages = with pkgs; [
         kdePackages.qtsvg
         kdePackages.qtmultimedia
         kdePackages.qtvirtualkeyboard
         sddm-astronaut
       ];
       theme = "sddm-astronaut-theme";
      };
      
      xserver = {
        enable = true;
      };

      gvfs = {
        enable = true;
      };

      gnome = {
        gnome-keyring = {
          enable = true;
        };
      };
    };

    # locking with swaylock
    security = {
      pam = {
        services = {
          swaylock = {
            text = "auth include login";
          };
        };    
      };

      polkit = {
        enable = true;
      };
    };

    # Hyprland joins the battle!
    programs = {
      hyprland = {
        enable = true;
      };
    };    

    # Polkit on Hyprland needs some extra love
    systemd = {
      user = {
        services = {
          polkit-gnome-authentication-agent-1 = {
            description = "polkit-gnome-authentication-agent-1";
            wantedBy = [ "graphical-session.target" ];
            wants = [ "graphical-session.target" ];
            after = [ "graphical-session.target" ];
            serviceConfig = {
              Type = "simple";
              ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
              Restart = "on-failure";
              RestartSec = 1;
              TimeoutStopSec = 10;
            };
          };    
        };
      };
    };

    # XDG Desktop Portal
    xdg = {
      portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-hyprland
          xdg-desktop-portal-gtk
        ];
      };
    };

    # Hyprland-specific packages
    environment = {
      systemPackages = with pkgs; [
        adwaita-fonts
        ffmpeg
        ffmpegthumbnailer
        fuzzel
        grimblast
        hyprpaper
        libsForQt5.qt5.qtgraphicaleffects
        libsForQt5.sddm-kcm
        lxqt.lxqt-policykit
        kitty
        nwg-look
        pamixer
        pavucontrol
        playerctl
        polkit_gnome
        rofi
        swaybg
        swaylock-effects
        swaynotificationcenter
        viewnior
        waybar
        wlogout
        wl-clipboard
        xarchiver
        xfce.thunar
        xfce.thunar-volman
        xfce.thunar-archive-plugin
        xfce.tumbler
      ];
      
      variables = {
        POLKIT_BIN = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      };
    };
  };  
}
