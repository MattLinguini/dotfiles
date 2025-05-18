{ config, pkgs, user, ... }:

{
  home = {
    username = "${user.name}";
    homeDirectory = "${user.homeDir}";
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
