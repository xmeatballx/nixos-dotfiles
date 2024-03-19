{ config, ... }:

{
  xsession.windowManager.i3.config.bars = [
    {
      position = "top";
      statusCommand = "i3status";
      fonts = {
        names = [ "JetBrainsMono" ];
        size = 11.0;
      };
      trayOutput = "primary";
    }
  ];
}
