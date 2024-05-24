{ config, pkgs, ... }:

{
  imports = [ 
   ./common.nix
    <nixpkgs/nixos/modules/virtualisation/lxc-container.nix>
 ];
  systemd.mounts = [{
    where = "/sys/kernel/debug";
    enable = false;
  }];
  users.users.dev = {
    isNormalUser  = true;
    home  = "/home/dev";
    description  = "generic dev user";
    extraGroups  = [ "wheel" "networkmanager" ];
  };  
}
