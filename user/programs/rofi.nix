{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    theme = "DarkBlue";    
    plugins = with pkgs; [
      rofi-screenshot
    ];
  };
}
