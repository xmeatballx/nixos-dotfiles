{ config, pkgs, ... }:
{
  home-manager.packages = [
    pkgs.rofi-screenshot
  ];
  programs.rofi = {
    enable = true;
    theme = "DarkBlue";    
  };
}
