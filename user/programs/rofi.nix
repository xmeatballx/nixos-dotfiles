{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    theme = "DarkBlue";    
    extraPackages = with pkgs; [
      rofi-screenshot
    ];
  };
}
