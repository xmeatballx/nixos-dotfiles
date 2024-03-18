{ config, pkgs, lib, ... }:
let
  wallpaper = ./config/wallpapers/nix_dark.png;
in
{
  imports = [
    ./i3
    ./programs
    ./services
  ];
  home.username = "meatball";
  home.homeDirectory = "/home/meatball";

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
    kitty
    image-roll
    neofetch
    google-chrome
    slack
    discord
    brightnessctl
    typescript
    jellyfin-media-player
    mongodb-compass

    (pkgs.writeShellScriptBin "reconfig" ''
           function showProgress() {
             local command="$1"
             local commonName="$2"
             local FRAMES="/ | \\ -"
             local status=0
             local pid=0

             if [ $commonName == "System" ]; then
               #read -s -p "Enter sudo password: " sudo_password
               #echo "$sudo_password" | 
               sudo -A $command &> nixos-switch.log || (cat nixos-switch.log | grep --color error && false) & pid=$!
             else
               $command &> nixos-switch.log || (cat nixos-switch.log | grep --color error && false) & pid=$!
             fi

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
           showProgress "home-manager switch --flake .#meatball" "Home-Manager"
           showProgress "nixos-rebuild switch --flake .#nixos-laptop" "System"
           rm nixos-switch.log
           gen=$(nixos-rebuild list-generations | grep current);
           git commit -am "$gen"
           popd &> /dev/null
    '')
  ];

  home.file = {
    ".background-image" = {
      source = "${wallpaper}";
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
