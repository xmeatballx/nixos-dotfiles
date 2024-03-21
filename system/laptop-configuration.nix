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

  powerManagement.enable = true;

  services.thermald.enable = true;

  services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;

       #Optional helps save long term battery health
       START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
       STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

      };
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

  services.logind.lidSwitch = "ignore";
  services.acpid = {
    enable = true;
    lidEventCommands =
    ''
      export PATH=$PATH:/run/current-system/sw/bin

      lid_state=$(cat /proc/acpi/button/lid/LID0/state | awk '{print $NF}')
      if [ $lid_state = "closed" ]; then
        # Set brightness to zero
        echo 0  > /sys/class/backlight/acpi_video0/brightness
      else
        # Reset the brightness
        echo 50  > /sys/class/backlight/acpi_video0/brightness
      fi
    '';

    powerEventCommands =
    ''
      systemctl suspend
    '';
  };

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
