{ config, pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "browser" '' nvidia-offload google-chrome-stable '')
  ];
}
