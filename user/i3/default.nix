{ config, pkgs, lib, ... }:
{
#  home.packages = [ pkgs.i3-gaps ];
  imports = [
    ./keybindings.nix
    ./colors.nix
    ./bar.nix
  ];
    
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      terminal = "kitty";
      gaps = {
        inner = 5;
        outer = 2;
        smartGaps = true;
      };
    };
    extraConfig = ''
      for_window [class="Google-chrome"] border pixel 0
    '';
  };
}
