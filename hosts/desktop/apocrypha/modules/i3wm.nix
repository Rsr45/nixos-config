{config, pkgs, inputs, ...}:
{
  xsession.windowManager.i3 = {
    enable = true;
  };
  xdg.configFile = {
    "i3" = {
      source = ./config-dir/i3-conf-dir;
      recursive = true;
    };
    "i3status" = {
      source = ./config-dir/i3status-conf-dir;
      recursive = true;
    };
    "polybar" = {
      source = ./config-dir/polybar-conf-dir;
      recursive = true;
    };
  };
}
