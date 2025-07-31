{ config, pkgs, lib, ... }:
let
  wallpaper = ./config/wallpapers/pixel2.png;
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
    glib
    xdotool

    kitty
    neofetch
    btop
    du-dust
    bat
    redis

    brightnessctl
    dunst #notification daemon
    pavucontrol #sound settings GUI
    lxappearance #app theming

    image-roll #image viewer

    google-chrome
    firefox
    spotify
    spotify-tray
    jellyfin-media-player
    inkscape
    strawberry
    haruna
    thunderbird
    anki
    autokey

    slack
    discord

    mongodb-compass
    typescript
    bruno

    marktext
    todoist-electron
  ];

  #home.file = {
  #  ".background-image" = {
  #    source = "${wallpaper}";
  #  };
  #};

  stylix = {
    enable = true;
    autoEnable = true;
    image = ../user/config/wallpapers/pixel2.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/black-metal.yaml";
    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      monospace = {
        package = pkgs.jetbrains-mono;
        name = "JetBrains Mono";
      };
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
