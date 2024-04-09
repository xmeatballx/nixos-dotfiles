
{ config, pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "chrome" '' nvidia-offload google-chrome-stable --app=https://notion.so '')
  ];
}
