{ config, ... }:

{
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    # font.name = "JetBrainsMono";
    #font.size = 13;
    extraConfig = '' 
      enable_audio_bell no
      confirm_os_window_close 0
    '';
  };
}
