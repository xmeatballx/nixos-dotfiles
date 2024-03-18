{ config, pkgs, lib, ... }:
let 
  mod = "Mod4";

  rosewater = "#f5e0dc";
  peach = "#fab387";
  lavender = "#b4befe";
  text = "#cdd6f4";
  overlay0 = "#6c7086";
  base = "#1e1e2e";
in
{
#  home.packages = [ pkgs.i3-gaps ];
    
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      terminal = "kitty";
      modifier = "Mod4";
      gaps = {
        inner = 5;
        outer = 5;
        smartGaps = true;
      };
      keybindings = with pkgs; {
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";

        "${mod}+Return" = "exec ${kitty}/bin/kitty";

        "${mod}+y" = "split h";
        "${mod}+u" = "split v";
        "${mod}+f" = "fullscreen toggle";
        "${mod}+Shift+space" = "floating toggle";
        "${mod}+Shift+c" = "kill";
        "${mod}+Shift+e" = "exec i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'Yes' 'i3-msg exit'";
        "${mod}+Shift+t" = "workspace_layout toggle tabbed splitv";
        #        "${mod}+Shift+e" = "reload";
        "${mod}+Shift+r" = "restart";
        "${mod}+Shift+q" = "kill";
        "${mod}+d" = "exec dmenu_run";

        "${mod}+Shift+1" = "exec i3-msg move container workspace 1 && i3-msg workspace 1";
        "${mod}+Shift+2" = "exec i3-msg move container workspace 2 && i3-msg workspace 2";
        "${mod}+Shift+3" = "exec i3-msg move container workspace 3 && i3-msg workspace 3";
        "${mod}+Shift+4" = "exec i3-msg move container workspace 4 && i3-msg workspace 4";
        "${mod}+Shift+5" = "exec i3-msg move container workspace 5 && i3-msg workspace 5";
        "${mod}+Shift+6" = "exec i3-msg move container workspace 6 && i3-msg workspace 6";
        "${mod}+Shift+7" = "exec i3-msg move container workspace 7 && i3-msg workspace 7";
        "${mod}+Shift+8" = "exec i3-msg move container workspace 8 && i3-msg workspace 8";
        "${mod}+Shift+9" = "exec i3-msg move container workspace 9 && i3-msg workspace 9";
        "${mod}+Shift+0" = "exec i3-msg move container workspace 0 && i3-msg workspace 0";

        "${mod}+1" = "workspace 1";
        "${mod}+2" = "workspace 2";
        "${mod}+3" = "workspace 3";
        "${mod}+4" = "workspace 4";
        "${mod}+5" = "workspace 5";
        "${mod}+6" = "workspace 6";
        "${mod}+7" = "workspace 7";
        "${mod}+8" = "workspace 8";
        "${mod}+9" = "workspace 9";
        "${mod}+10" = "workspace 10";

        "XF86AudioLowerVolume" = "exec pamixer -d 5";
        "XF86AudioRaiseVolume" = "exec pamixer -i 5";
        "XF86AudioMute" = "exec pamixer -t";

        "XF86MonBrightnessUp" = "exec brightnessctl set 10%+";
        "XF86MonBrightnessDown" = "exec brightnessctl set 10%- -n 100";
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
      colors = {
        background = "${base}";
        focused = {
          border = "${lavender}";
          background = "${base}";
          text = "${text}";
          indicator = "${rosewater}";
          childBorder = "${lavender}";
        };
        focusedInactive = {
          border = "${overlay0}";
          background = "${base}";
          text = "${text}";
          indicator = "${rosewater}";
          childBorder = "${overlay0}";
        };
        unfocused = {
          border = "${overlay0}";
          background = "${base}";
          text = "${text}";
          indicator = "${rosewater}";
          childBorder = "${overlay0}";
        };
        urgent = {
          border = "${peach}";
          background = "${base}";
          text = "${peach}";
          indicator = "${overlay0}";
          childBorder = "${peach}";
        };
        placeholder = {
          border = "${overlay0}";
          background = "${base}";
          text = "${text}";
          indicator = "${overlay0}";
          childBorder = "${overlay0}";
        };
      };
    };
    extraConfig = ''
      for_window [class="Google-chrome"] border pixel 0
    '';
  };
}
