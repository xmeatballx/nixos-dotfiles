{ config, ... }:
let
  colors = import ../colors/catppuccin-mocha.nix;
in
{
  xsession.windowManager.i3.config.bars = with colors; [
    {
      position = "top";
      statusCommand = "i3status";
      fonts = {
        names = [ "JetBrainsMono" ];
        size = 11.0;
      };
      trayOutput = "primary";
      colors = {
        background        ="${base}";
        statusline        ="${text}";
        focused_statusline="${text}";
        active_workspace  ="${base} ${text} ${lavender}";
        focused_separator ="${base}";
        focused_workspace ="${base} ${base} ${rosewater}";
        inactive_workspace="${base} ${base} ${surface1}";
        urgent_workspace  ="${base} ${base} ${surface1}";
        binding_mode      ="${base} ${base} ${surface1}";
      };
    }
  ];
}
