{ config, ... }:

{
  xsession.windowManager.i3.config.startup = [
    { command = "exec --no-startup-id spotify-tray"; }
  ];
}
