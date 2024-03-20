{ config, pkgs, lib, ... }:
let
  wallpaper = ./config/wallpapers/nix_dark.png;
in
{
  imports = [
    ./i3
    ./programs
    ./services
    ./scripts
  ];
  home.username = "meatball";
  home.homeDirectory = "/home/meatball";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  home.packages = with pkgs; [
    kitty
    neofetch
    btop
    du-dust
    bat
    
    brightnessctl
    dunst #notification daemon
    pavucontrol #sound settings GUI

    image-roll #image viewer

    google-chrome
    spotify
    spotify-tray
    jellyfin-media-player

    slack
    discord

    mongodb-compass
    typescript
  ];

  home.file = {
    ".background-image" = {
      source = "${wallpaper}";
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
