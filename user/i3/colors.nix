{ config, ... }:
let
  rosewater = "#f5e0dc";
  peach = "#fab387";
  lavender = "#b4befe";
  text = "#cdd6f4";
  overlay0 = "#6c7086";
  base = "#1e1e2e";
in
{
  xsession.windowManager.i3.config.colors = {
    background = "${base}";
    focused = {
      border = "${lavender}";
      background = "${base}";
      text = "${text}";
      indicator = "${rosewater}";
      childBorder = "${lavender}";
    };
    focusedInactive = {
      border = "${overlay0}";
      background = "${base}";
      text = "${text}";
      indicator = "${rosewater}";
      childBorder = "${overlay0}";
    };
    unfocused = {
      border = "${overlay0}";
      background = "${base}";
      text = "${text}";
      indicator = "${rosewater}";
      childBorder = "${overlay0}";
    };
    urgent = {
      border = "${peach}";
      background = "${base}";
      text = "${peach}";
      indicator = "${overlay0}";
      childBorder = "${peach}";
    };
    placeholder = {
      border = "${overlay0}";
      background = "${base}";
      text = "${text}";
      indicator = "${overlay0}";
      childBorder = "${overlay0}";
    };
  };
}
