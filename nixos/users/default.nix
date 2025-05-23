{ config, lib, pkgs, ... }:

{
  users = {
    users = {
      buber = {
        isNormalUser = true;
        description = "Tomek Bobrowicz";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        shell = pkgs.zsh;
        packages = with pkgs; [
        ];
        openssh = {
          authorizedKeys = {
            keys = [
            ];
          };
        };
      };
    };
  };
}
