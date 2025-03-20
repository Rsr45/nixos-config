{...}: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        reload_style_on_change = true;
        modules-left = ["hyprland/workspaces"];
        modules-center = ["clock"];
        modules-right = ["wireplumber"];

        "wireplumber" = {
          format = "{volume}%";
          format-muted = "";
          on-click = "pwvucontrol";
        };
      };
    };
  };
}
