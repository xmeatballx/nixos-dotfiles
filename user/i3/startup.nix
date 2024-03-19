{ config, ... }:

{
  xsession.windowManager.i3.config.startup = [
    { command = "spotify-tray -m"; }
  ];
}
