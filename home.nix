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
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
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

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    image-roll
    nitrogen
    i3-gaps
    cmake
    gcc
    neofetch

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    (pkgs.writeShellScriptBin "reconfig" ''
      nvim ~/nixos-dotfiles
      git diff -U0
      echo "NixOS Rebuilding..."
      sudo nixos-rebuild switch ~/nixos-dotfiles&>nixos-switch.log || (
      cat nixos-switch.log | grep --color error && false)
      gen=$(nixos-rebuild list-generations | grep current)
      git commit -am "$gen"
      sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos-main
    '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

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

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/meatball/etc/profile.d/hm-session-vars.sh
  #
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
      };
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
      startup = [ 
        { command = "--no-startup-id nitrogen --set-zoom-fill .config/wallpapers/wallpaper.png"; always = true; }
        { command = "picom --daemon --config ~/.config/picom/default.conf"; always = true; } 
       # { command = "--no-startup-id picom --daemon"; always = true; } 
      ];
    };
  };


  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    theme = "Catppuccin-Mocha";
    font.name = "JetBrainsMono";
    font.size = 13;
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
