{ config, ... }:

{
  xsession.windowManager.i3.config.startup = [
    "exec --no-startup-id spotify-tray"
  ];
}
