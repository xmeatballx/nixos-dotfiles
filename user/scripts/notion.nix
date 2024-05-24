
{ config, pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "notion" '' nvidia-offload google-chrome-stable --app=https://notion.so '')
  ];
}
