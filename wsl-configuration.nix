# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "meatball";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  users.users.meatball = {
    isNormalUser = true;
    description = "meat ball";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];
  };

  nixpkgs.config.allowUnfree = true;

  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
     vim 
     git
     kitty
     docker-compose
     nodejs_21
     wget
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
  
  security.acme = {
    acceptTerms = true;
    defaults.email = "erik.rjensen@yahoo.com";
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking.firewall.allowedUDPPorts = [ 80 443 ];
  

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
