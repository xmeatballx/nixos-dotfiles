{
  imports = [
    ./blueman.nix
    ./picom.nix
  ];

  services.spotifyd.enable = true;
}
