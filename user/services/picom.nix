{ config, ... }:

{
  services.picom = {
    enable = true;
    activeOpacity = 0.95;
    inactiveOpacity = 0.9;
    fade = true;
    opacityRules = [ 
      "100:class_g = 'Google-chrome'"
      "100:class_g = 'Inkscape'"
      "100:class_g = 'haruna'"
    ];
  };
}
