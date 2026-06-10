{
  lib,
  config,
  ...
}: {
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps
    checkConfig = false;
    config = let
      modifier = config.wayland.windowManager.sway.config.modifier;
    in {
      modifier = "Mod4";
      # Use kitty as default terminal
      terminal = "kitty";
      startup = [
        # Launch Firefox on start
        {command = "floorp";}
      ];

      keybindings = lib.mkOptionDefault {
        "${modifier}+t" = "exec kitty";
        "${modifier}+space" = "exec vicinae toggle";
        # Super + Shift + S
        # Screenshot a selection that saves to ~/Screenshots and copies to clipboard.
        "${modifier}+Shift+s" = "exec selection=$(slurp) && grim -g \"$selection\" - | tee ~/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png | wl-copy --type image/png";

        # Print Screen Button
        # Screenshot the currently focused screen, save to ~/Screenshots and copy to clipboard.
        "Print" = "exec grimshot save output - | tee ~/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png | wl-copy --type image/png";
      };
    };
  };
}
