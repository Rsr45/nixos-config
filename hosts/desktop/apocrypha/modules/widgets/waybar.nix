{...}: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        name = "mainBar";
        layer = "top";
        position = "top";
        height = 30;
        spacing = 0;
        reload_style_on_change = true;
        modules-left = ["custom/blank" "hyprland/workspaces"];
        modules-center = ["clock"];
        modules-right = ["wireplumber" "disk" "cpu" "memory" "custom/seperator" "network" "custom/power" "custom/blank"];

        "custom/seperator" = {
          format = " | ";
          tooltip = false;
        };

        "custom/blank" = {
          format = "  ";
          tooltip = false;
        };

        "custom/power" = {
          format = "  ";
          on-click = "wlogout";
          tooltip = false;
        };

        "hyprland/workspaces" = {
          # format = "{icon}";
          # format-icons = {
          #   default = "";
          #   urgent = "";
          #   active = "";
          # };
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
          format = "{volume}% ";
          format-muted = "x% ";
          on-click = "pwvucontrol";
          on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };

        "disk" = {
          format = "{percentage_used}% ";
        };

        "cpu" = {
          format = "{usage}% ";
        };

        "memory" = {
          format = "{percentage}% ";
        };

        "tray" = {
          spacing = 5;
        };

        "network" = {
          format-wifi = " ";
          format-ethernet = " ";
          format-disconnected = " ";
          tooltip-format-disconnected = "Error";
          tooltip-format-wifi = "{essid} ({signalStrength}%)  ";
          tooltip-format-ethernet = "{ifname} 🖧 ";
          on-click = "nm-connection-editor";
        };
      };

      bottomBar = {
        name = "bottomBar";
        layer = "top";
        position = "bottom";
        height = 20;
        spacing = 0;
        reload_style_on_change = true;

        modules-left = ["custom/blank"];
        modules-right = ["tray" "custom/blank"];

        "custom/blank" = {
          format = " ";
          tooltip = false;
        };

        "tray" = {
          spacing = 0;
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
      }
      window#waybar.bottomBar {
        background: #16191C;
        color: #AAB2BF;
      }
      #workspaces button {
        padding: 0 5px;
      }
    '';
  };
}
