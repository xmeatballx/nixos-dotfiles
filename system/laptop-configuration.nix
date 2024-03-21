{ config, pkgs, ... }:

{
  imports = [
      ./hardware/laptop-hardware-configuration.nix
      ./common.nix
  ];    
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  networking.enableIPv6  = false;

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

  services.logind.lidSwitchExternalPower = "ignore";

  environment.etc = {
    "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
        bluez_monitor.properties = {
          ["bluez5.enable-sbc-xq"] = true,
          ["bluez5.enable-msbc"] = true,
          ["bluez5.enable-hw-volume"] = true,
          ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
        }
    '';
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
     pamixer
  ];


  programs.nm-applet.enable = true;

  security.acme = {
    acceptTerms = true;
    defaults.email = "erik.rjensen@yahoo.com";
  };

  networking.firewall.allowedUDPPortRanges = [ { from = 32768; to = 60999; } ];

  services.avahi.enable = true;

  services.blueman.enable = true;
}
