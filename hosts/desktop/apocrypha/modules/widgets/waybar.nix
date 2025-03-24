{...}: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        reload_style_on_change = true;
        modules-left = ["tray"];
        modules-center = ["hyprland/workspaces" "custom/seperator" "clock"];
        modules-right = ["wireplumber" "network" "disk" "cpu" "memory"];

        "custom/seperator" = {
          format = "  ";
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            default = "  ";
            urgent = "  ";
            active = "  ";
          };
          persistent-workspaces = {
            "1" = "[]";
            "2" = "[]";
            "3" = "[]";
            "4" = "[]";
            "5" = "[]";
            "6" = "[]";
          };
        };

        "clock" = {
          format = "{:%R  %d %B %Y}";
          format-alt = "{:%R}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
          };
        };

        "wireplumber" = {
          format = "{volume}%";
          format-muted = "  ";
          on-click = "pwvucontrol";
          on-click-middle = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };

        "disk" = {
          format = "{percentage_used}%";
        };
      };
    };
  };
}
