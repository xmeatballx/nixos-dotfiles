{ config, pkgs, ... }:

{
  imports = [
      ./laptop-hardware-configuration.nix
    ];    
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver = {
    enable = true;
    libinput.touchpad.naturalScrolling  = true;

    desktopManager = {
      xterm.enable = false;
    };
   
    displayManager = {
      defaultSession = "none+i3";
    };

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
        feh
        picom
     ];
    };
  };

  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    jack.enable = true;
  };

  users.users.meatball = {
    isNormalUser = true;
    description = "meat ball";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
     vim 
     git
     kitty
     docker-compose
     nodejs_21
     wget
     pamixer
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "sudo" "docker" ];
      theme = "afowler";
    };
  };

  users.users.meatball.shell = pkgs.zsh;


  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = true;

  services.nginx = {
     enable = true;
     recommendedProxySettings = true;
     #recommendedTlsSettings = true;
     virtualHosts."meatball.dev.local" =  {
       #enableACME = true;
       #forceSSL = true;
       locations."/" = {
         proxyPass = "http://127.0.0.1:3000";
        # extraConfig =
           # required when the target is also TLS server with multiple hosts
        #  "proxy_ssl_server_name on;" +
           # required when the server wants to use HTTP Authentication
        #  "proxy_pass_header Authorization;"
        #  ;
        };
     };
  };
  
  programs.git = {
    enable = true;
    config = {
      init = {
          defaultBranch = "main";
      };
      credential.helper = "store";
    };
  };  

  programs.light.enable = true;

  security.acme = {
    acceptTerms = true;
    defaults.email = "erik.rjensen@yahoo.com";
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking.firewall.allowedUDPPorts = [ 80 443 ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
  nix.settings.experimental-features = ["nix-command" "flakes"];
}
