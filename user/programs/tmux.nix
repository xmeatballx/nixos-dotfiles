{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    mouse = true;
    keyMode = "vi";
    prefix = "C-Mod4";
  };
}
