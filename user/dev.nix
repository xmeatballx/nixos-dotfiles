{ config, pkgs, lib, ... }:
{
  imports = [
    ./programs
    ./scripts
  ];
  home.username = "dev";
  home.homeDirectory = "/home/dev";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  home.packages = with pkgs; [
    neofetch
    btop
    du-dust
    bat
    redis
    typescript 
  ];
    
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.tmux.prefix = lib.mkForce "^@";
  programs.tmux.extraConfig = lib.mkForce ''
      # set shell
      set -g default-shell /nix/store/2mz9knjdab5war1psdbiji3rikl82d0c-system-path/bin/zsh
  '';

  programs.home-manager.enable = true;
}

