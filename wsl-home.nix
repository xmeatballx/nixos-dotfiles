{ config, pkgs, ... }:
let 
  rosewater="#f5e0dc";
  peach    ="#fab387";
  lavender ="#b4befe";
  text     ="#cdd6f4";
  overlay0 ="#6c7086";
  base     ="#1e1e2e";
  wallpaper=./config/wallpapers/pixels.png;
  mod      ="Mod4";
in 
{
  home.username = "meatball";
  home.homeDirectory = "/home/meatball";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    image-roll
    nitrogen
    i3-gaps
    cmake
    gcc
    neofetch

    (pkgs.writeShellScriptBin "reconfig" ''
      function showProgress() {
        local command="$1"
        local commonName="$2"
        local FRAMES="/ | \\ -"
        local status=0

        $command &> nixos-switch.log || (cat nixos-switch.log | grep --color error && false) & pid=$!

        while ps -p $pid > /dev/null; do
            for frame in $FRAMES; do
                printf "\r$frame Syncing $commonName configuration..."
                sleep 0.2
            done
            if ! kill -0 $pid 2>/dev/null; then
                wait $pid
                status=$?
                break
            fi
        done

        if [ $status -eq 0 ]; then
            printf "\r$GREEN✓$NC Syncing $commonName configuration...$GREEN [Success!]$NC\n"
        else
            printf "\r$RED×$NC Syncing $commonName configuration...$RED [Failed!]$NC\n"
        fi
        printf "\n"
      }

      pushd ~/nixos-dotfiles &> /dev/null
      nvim .
      git diff -U0
      showProgress "home-manager switch --flake .#wsl" "Home-Manager"
      showProgress "sudo nixos-rebuild switch --flake .#nixos-wsl" "System" 
      rm nixos-switch.log
      gen=$(nixos-rebuild list-generations | grep current);
      git commit -am "$gen"
      popd &> /dev/null
    '')
  ];

  home.file = {
    ".config/nvim" = {
      source = ./config/nvim;
      recursive = true;
    };

    ".config/wallpapers/wallpaper.png" = {
        source = "${wallpaper}";
    };

    ".config/picom/default.conf" = {
        source = ./config/picom/default.conf;
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.neovim = { 
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}