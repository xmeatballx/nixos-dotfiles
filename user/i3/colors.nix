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

  xsession.windowManager.i3.config.bars.colors = with colors; {
    colors = {
      background = "${base}";
      statusline = "${text}";
      focusedStatusline = "${text}";
      focusedSeparator = "${base}";
      focusedWorkspace = {
        border = "${base}";
        background = "${base}";
        text = "${rosewater}";
      };
      inactiveWorkspace = {
        border = "${base}";
        background = "${base}";
        text = "${surface1}";
      };
      urgentWorkspace = {
        border = "${base}";
        background = "${base}";
        text = "${surface1}";
      };
      bindingMode = {
        border = "${base}";
        background = "${base}";
        text = "${surface1}";
      };
    };
  };
}
