{ config, ... }:
let
  colors = import ../colors/catppuccin-mocha.nix;
in
{
  xsession.windowManager.i3.config.colors = with colors; {
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
