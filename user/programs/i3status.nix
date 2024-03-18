{config, ...}:

{
  programs.i3status = {
    enable = true;
    enableDefault = false;
    modules = {
      "tztime local" = {
        position = 1;
        settings = {
          format = "%I:%M%p %m/%d/%Y";
        };
      };
      "volume master" = {
        position = 1;
        settings = {
          format = "♪ %volume";
          format_muted = "♪ muted (%volume)";
          device = "default";
        };
      };
      "battery all" = {
        position = 2;
        settings = {
          format = "%status %percentage";
          status_bat = "🔋";
          status_chr = "⚡";
          status_full = "☻";
          status_unk = "?";
        };
      };
      "wireless _first_" = {
        position = 3;
        settings = {
          format_down = "no wifi";
          format_up = "%ip";
        };
      };
    };
  };
}
