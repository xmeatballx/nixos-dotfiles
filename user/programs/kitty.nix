{ config, ... }:

{
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    theme = "Catppuccin-Mocha";
    font.name = "JetBrainsMono";
    font.size = 13;
    extraConfig = '' enable_audio_bell no '';
  };
}
