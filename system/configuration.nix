{ config, pkgs, ... }:

{
  imports = [
      ./hardware-configuration.nix
      ./common.nix
  ];    
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  virtualisation.docker.enable = true;

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
}
