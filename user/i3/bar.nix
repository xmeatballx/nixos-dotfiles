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
        background = "${base}";
        statusline = "${text}";
        focusedStatusline = "${text}";
        focusedSeparator = "${base}";
        focusedWorkspace = {
          border = "${base}";
          text = "${base}";
          separator = "${rosewater}";
        };
        inactiveWorkspace = {
          border = "${base}";
          text = "${base}";
          separator = "${overlay0}";
        };
        urgentWorkspace = {
          border = "${base}";
          text = "${base}";
          separator = "${overlay0}";
        };
        bindingMode = {
          border = "${base}";
          text = "${base}";
          separator = "${overlay0}";
        };
      };
    }
  ];
}
