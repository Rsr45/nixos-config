{config, pkgs, inputs, ...}:
{
  xdg.configFile = {
    "sway" = {
      source = ../config-dir/sway-conf-dir;
      recursive = true;
    };
  };
}