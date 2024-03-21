{ config, ... }:

{
  programs.rofi = {
    enable = true;
    theme = "DarkBlue";    
    extraPackages = [
      rofi-screenshot
    ];
  };
}
