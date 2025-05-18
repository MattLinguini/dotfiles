{ config, pkgs, ... }:

{
  home = {
    username = "matt";
    homeDirectory = "/home/matt";
    stateVersion = "24.11";

    packages = with pkgs; [
      kitty
      hyprpaper
      waybar
      rofi-wayland
      dunst
      wl-clipboard
      brightnessctl
    ];

    sessionVariables = {};
  };

  programs.home-manager.enable = true;
}
