{...}: {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        ignore_dbusclose = true;
        width = 300;
        height = "(0, 300)";
        offset = "(30, 30)";
        origin = "top-right";
        corner_radius = "0";
        gap_size = "8";
        frame_width = "2";
        timeout = 1;
        override_dbus_timeout = 1;
      };
      urgency_critical = {
        timeout = 1;
        override_dbus_timeout = 1;
      };
    };
  };
}
