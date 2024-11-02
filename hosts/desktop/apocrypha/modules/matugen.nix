{...}: {
  xdg.configFile = {
    "matugen" = {
      source = ../config-dir/matugen-conf-dir;
      recursive = true;
    };
  };
}
