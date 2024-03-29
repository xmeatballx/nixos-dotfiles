{ config, pkgs, ... }:
let 
  mod = "Mod4";
in
{
  xsession.windowManager.i3.config.modifier = "Mod4";
  xsession.windowManager.i3.config.keybindings = with pkgs; {
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
    "${mod}+Shift+t" = "layout toggle tabbed splitv";
    #        "${mod}+Shift+e" = "reload";
    "${mod}+Shift+r" = "restart";
    "${mod}+Shift+q" = "kill";
    "${mod}+space" = "exec rofi -show combi";

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
}
