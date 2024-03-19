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
        activeWorkspace = {
          border = "${base}";
          background = "${text}";
          text = "${blue}";
        };
        focusedWorkspace = {
          border = "${base}";
          background = "${base}";
          text = "${green}";
        };
        inactiveWorkspace = {
          border = "${base}";
          background = "${base}";
          text = "${overlay0}";
        };
        urgentWorkspace = {
          border = "${base}";
          background = "${base}";
          text = "${overlay0}";
        };
        bindingMode = {
          border = "${base}";
          background = "${base}";
          text = "${overlay0}";
        };
      };
    }
  ];
}
