{ config, pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "browser" '' nvidia-offload google-chrome-stable '')
    (pkgs.writeShellScriptBin "emoji" '' rofi -modi emoji -show emoji '')
    (pkgs.writeShellScriptBin "findfiles" '' rofi -show filebrowser -file-browser-stdin '')
    (pkgs.writeShellScriptBin "calculator" ''  rofi -show calc -modi calc -no-show-match -no-sort  '')
  ];
}
