{ config, pkgs, ... }:
{
  home.packages = [
      pkgs.rofi-screenshot
  ];

  programs.rofi = {
    enable = true;
    plugins = [
      pkgs.rofi-emoji
      pkgs.rofi-calc
      pkgs.rofi-file-browser
    ];
  };

  services.clipmenu.enable = true;
  services.clipmenu.launcher = "rofi";
}
