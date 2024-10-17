{ config, lib, pkgs, ... }:

let
  # Path to your binary
  lookerBinary = ../bin/looker; # Adjust this path as needed
in
{
  # Create a package to handle the binary
  home.packages = [
    (pkgs.runCommand "looker-bin" {
      # Make sure the source file is available during the build
      src = lookerBinary;
    } ''
      mkdir -p $out/bin
      cp $src $out/bin/looker
      chmod +x $out/bin/looker
    '')
  ];
}
