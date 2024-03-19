{ config, pkgs, lib, ... }:
{
#  home.packages = [ pkgs.i3-gaps ];
  imports = [
    ./keybindings.nix
    ./colors.nix
    ./bar.nix
    ./i3status.nix
    ./startup.nix
  ];
    
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      terminal = "kitty";
      gaps = {
        inner = 5;
        outer = 1;
        smartGaps = true;
      };
      focus = {
        newWindow = "focus";
      };
    };
    extraConfig = ''
      for_window [class="Google-chrome"] border pixel 0
    '';
  };
}
