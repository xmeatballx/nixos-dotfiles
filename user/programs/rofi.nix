{ config, pkgs, ... }:
{
  home.packages = [
    pkgs.rofi-screenshot
  ];
  programs.rofi = {
    enable = true;
    theme = "DarkBlue";    
  };
}
