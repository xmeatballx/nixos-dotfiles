{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    mouse = true;
    keyMode = "vi";
    prefix = "C-Space";
    plugins = with pkgs; [
      tmuxPlugins.catppuccin
      tmuxPlugins.vim-tmux-navigator
    ];
    extraConfig = '' 
      # set shell
      set -g default-shell /nix/store/2mz9knjdab5war1psdbiji3rikl82d0c-system-path/bin/zsh
      unbind C-.
      set -g @plugin 'tmux-plugins/tmux-resurrect'
      set -g @plugin 'tmux-plugins/tmux-continuum'
    '';
  };
}
