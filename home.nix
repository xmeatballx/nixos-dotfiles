{ config, pkgs, ... }:
let 
  rosewater="#f5e0dc";
  peach    ="#fab387";
  lavender ="#b4befe";
  text     ="#cdd6f4";
  overlay0 ="#6c7086";
  base     ="#1e1e2e";
  wallpaper=./config/wallpapers/nix_dark.png;
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

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  home.packages = with pkgs; [
    image-roll
    i3-gaps
    cmake
    gcc
    neofetch
    google-chrome
    slack
    discord
    brightnessctl

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
      showProgress "home-manager switch --flake .#meatball" "Home-Manager"
      
      read -s -p "Enter sudo password: " sudo_password

      showProgress "echo "$sudo_password" | sudo -S nixos-rebuild switch --flake .#nixos-laptop"
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

    ".background-image" = {
        source = "${wallpaper}";
    };

    #".config/i3status/config" = {
    #  source = ./config/i3status/config;
    #};
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

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
#        "${mod}+Shift+e" = "reload";
        "${mod}+Shift+r" = "restart";
        "${mod}+Shift+q" = "kill";
        "${mod}+d"= "exec dmenu_run";

        "${mod}+Shift+1" = "move container workspace 1";
        "${mod}+Shift+2" = "move container workspace 2";
        "${mod}+Shift+3" = "move container workspace 3";
        "${mod}+Shift+4" = "move container workspace 4";
        "${mod}+Shift+5" = "move container workspace 5";
        "${mod}+Shift+6" = "move container workspace 6";
        "${mod}+Shift+7" = "move container workspace 7";
        "${mod}+Shift+8" = "move container workspace 8";
        "${mod}+Shift+9" = "move container workspace 9";
        "${mod}+Shift+0" = "move container workspace 10";

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

        "XF86MonBrightnessUp" = "exec brightnessctl set 10%+";
        "XF86MonBrightnessDown" = "exec brightnessctl set 10%- -n 100";
      };
      bars = [
        {
          position = "top";
          statusCommand = "i3status";
          fonts = {
            names = [ "JetBrainsMono"];
            size = 11.0;
          };
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


  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    theme = "Catppuccin-Mocha";
    font.name = "JetBrainsMono";
    font.size = 13;
    extraConfig = '' enable_audio_bell no '';
  };

  programs.neovim = { 
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  programs.git = {
    enable = true;
    userEmail = "erik.jensen5@pcc.edu";
    userName = "xmeatballx";
  };

  programs.i3status = {
    enable = true;
    enableDefault = false;
    modules = {
      "tztime local" = {
        position = 1;
        settings = {
          format = "%I:%M %p %m-%d-%Y";
        };
      }; 
      "volume master" = {
        position = 1;
        settings = {
          format = "♪ %volume";
          format_muted = "♪ muted (%volume)";
          device = "pulse:1";
        };
      };
      "battery all" = {
        position = 2;
        settings = {
          format = "%status %percentage";
          status_bat = "🔋";
          status_chr = "⚡";
          status_full = "☻";
          status_unk = "?";
        };
      };
      "wireless _first_" = {
        position = 3;
        settings = {
          format_down = "no wifi";
          format_up = "%ip";
        };
      };
    };
  };

  services.picom = {
    enable = true;
    activeOpacity = 0.95;
    inactiveOpacity = 0.9;
    fade = true;
    opacityRules = [ "100:class_g = 'Google-chrome'" ];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
