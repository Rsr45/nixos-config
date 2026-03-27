{
  config,
  pkgs,
  ...
}:
{
  services.xserver.displayManager.startx = {
    enable = true;
    generateScript = true;
  };
  services.greetd = {
    enable = true;
    useTextGreeter = true;

    restart = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions --xsessions ${config.services.displayManager.sessionData.desktops}/share/xsessions --remember --remember-user-session --asterisks --time --time-format '%I:%M %p | %a • %h | %F'";
        user = "greeter";
      };
    };
  };
}
