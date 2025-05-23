{ config, pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      adwaita-fonts
      dina-font
      fira-code
      fira-code-symbols
      jetbrains-mono
      liberation_ttf
      mplus-outline-fonts.githubRelease
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      proggyfonts
      vegur
    ];
  };
}