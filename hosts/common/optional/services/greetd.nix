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
        # command = "${pkgs.tuigreet}/bin/tuigreet --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions --xsessions ${config.services.displayManager.sessionData.desktops}/share/xsessions --remember --remember-user-session --asterisks --time --time-format '%I:%M %p | %a • %h | %F' --theme 'border=#${config.lib.stylix.colors.base05};text=#${config.lib.stylix.colors.base05};prompt=#${config.lib.stylix.colors.base05};time=#${config.lib.stylix.colors.base05};action=#${config.lib.stylix.colors.base05};button=yellow;container=black;input=red'";
        user = "greeter";
      };
    };
  };
}
