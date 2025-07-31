{ config, pkgs, ... }:
{
  home.packages = [
      pkgs.rofi-screenshot
  ];

  programs.rofi = {
    enable = true;
    terminal = "kitty";
    plugins = [
      pkgs.rofi-emoji
      pkgs.rofi-calc
      pkgs.rofi-file-browser
    ];
    theme = let 
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "window" = {
        border-radius = 8;
      };

      "mainbox" = {
        padding = 12;
      };

      "#inputbar" = {
        children = map mkLiteral [ "prompt" "entry" ];
        padding = mkLiteral "8px 16px";
        spacing = 8;
        border = 2;
        border-radius = 4;
      };

      "message" = {
        margin = mkLiteral "12px 0 0";
        border-radius = 4;
      };

      "textbox" = {
        padding = mkLiteral "8px 24px";
      };

      "listview" = {
        margin = "12px 0 0";
        lines = 8;
        columns = 1;
        fixed-height = false;
      };

      "element" = {
        padding = mkLiteral "8px 12px";
        spacing = 8;
        border-radius = 4;
      };

      "element.normal.normal" = {
        background-color = mkLiteral "transparent";
      };

      "element.alternate.normal" = {
        background-color = mkLiteral "transparent";
      };
    };
  };

  services.clipmenu.enable = true;
  services.clipmenu.launcher = "rofi";
}
