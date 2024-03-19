{ config, pkgs, lib, ... }:
let 
  mod = "Mod4";
in
{
#  home.packages = [ pkgs.i3-gaps ];
  imports = [
    ./keybindings.nix
    ./colors.nix
  ];
    
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      terminal = "kitty";
      modifier = "Mod4";
      gaps = {
        inner = 5;
        outer = 2;
        smartGaps = true;
      };
      bars = [
        {
          position = "top";
          statusCommand = "i3status";
          fonts = {
            names = [ "JetBrainsMono" ];
            size = 11.0;
          };
          trayOutput = "primary";
        }
      ];
    };
    extraConfig = ''
      for_window [class="Google-chrome"] border pixel 0
    '';
  };
}
