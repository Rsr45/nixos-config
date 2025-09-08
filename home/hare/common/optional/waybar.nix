{ config, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      # mainBar = {
      #   name = "mainBar";
      #   layer = "top";
      #   position = "top";
      #   height = 28;
      #   spacing = 0;
      #   reload_style_on_change = true;
      #   modules-left = [
      #     "custom/blank"
      #     "hyprland/workspaces"
      #     "niri/workspaces"
      #   ];
      #   modules-center = [ "clock" ];
      #   modules-right = [
      #     "tray"
      #     # "wireplumber"
      #     # "disk"
      #     # "cpu"
      #     # "memory"
      #     "custom/seperator"
      #     "network"
      #     "custom/power"
      #     "custom/blank"
      #   ];
      #
      #   "custom/seperator" = {
      #     format = " | ";
      #     tooltip = false;
      #   };
      #
      #   "custom/blank" = {
      #     format = "  ";
      #     tooltip = false;
      #   };
      #
      #   "custom/power" = {
      #     format = "  ";
      #     on-click = "wlogout";
      #     tooltip = false;
      #   };
      #
      #   "niri/workspaces" = {
      #     current-only = true;
      #   };
      #
      #   "hyprland/workspaces" = {
      #     # format = "{icon}";
      #     # format-icons = {
      #     #   default = "";
      #     #   urgent = "";
      #     #   active = "";
      #     # };
      #     persistent-workspaces = {
      #       "1" = "[]";
      #       "2" = "[]";
      #       "3" = "[]";
      #       "4" = "[]";
      #       "5" = "[]";
      #       "6" = "[]";
      #     };
      #   };
      #
      #   "clock" = {
      #     format = "{:%R  %d %B %Y}";
      #     format-alt = "{:%R}";
      #     tooltip-format = "<tt><small>{calendar}</small></tt>";
      #     calendar = {
      #       mode = "month";
      #       mode-mon-col = 3;
      #       weeks-pos = "right";
      #       on-scroll = 1;
      #       format = {
      #         months = "<span color='#ffead3'><b>{}</b></span>";
      #         days = "<span color='#ecc6d9'><b>{}</b></span>";
      #         weeks = "<span color='#99ffdd'><b>W{}</b></span>";
      #         weekdays = "<span color='#ffcc66'><b>{}</b></span>";
      #         today = "<span color='#ff6699'><b><u>{}</u></b></span>";
      #       };
      #     };
      #     actions = {
      #       on-click-right = "mode";
      #     };
      #   };
      #
      #   "wireplumber" = {
      #     format = "{volume}% ";
      #     format-muted = "x% ";
      #     on-click = "pwvucontrol";
      #     on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      #   };
      #
      #   "disk" = {
      #     format = "{percentage_used}% ";
      #   };
      #
      #   "cpu" = {
      #     format = "{usage}% ";
      #   };
      #
      #   "memory" = {
      #     format = "{percentage}% ";
      #   };
      #
      #   "tray" = {
      #     spacing = 5;
      #   };
      #
      #   "network" = {
      #     format-wifi = " ";
      #     format-ethernet = " ";
      #     format-disconnected = " ";
      #     tooltip-format-disconnected = "Error";
      #     tooltip-format-wifi = "{essid} ({signalStrength}%)  ";
      #     tooltip-format-ethernet = "{ifname} 󰈀 ";
      #     on-click = "nm-connection-editor";
      #   };
      # };

      bottomBar = {
        name = "Bar";
        layer = "top";
        position = "top";
        height = 16;
        margin = "10 10 0 10";
        spacing = 4;
        reload_style_on_change = true;

        modules-left = [
          "hyprland/workspaces"
          "niri/workspaces"
          "custom/seperator"
          "tray"
        ];

        modules-right = [
          "network"
          "custom/seperator"
          "clock"
        ];

        "custom/blank" = {
          format = " ";
          tooltip = false;
        };

        "custom/seperator" = {
          format = "|";
          tooltip = false;
        };

        "hyprland/workspaces" = {
          all-outputs = true;
          format = "{icon}";
          format-icons = {
            "1" = "१";
            "2" = "२";
            "3" = "३";
            "4" = "४";
            "5" = "५";
            "6" = "६";
            "7" = "७";
            "8" = "८";
            "9" = "९";
            "10" = "०";
            # "10"= "१०";
          };
          persistent-workspaces = {
            "1" = "[]";
            "2" = "[]";
            "3" = "[]";
            "4" = "[]";
            "5" = "[]";
            "6" = "[]";
            "7" = "[]";
            "8" = "[]";
            "9" = "[]";
            "10" = "[]";
          };
        };

        "clock" = {
          format = "{:%R %d-%B-%Y}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "month";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#${config.lib.stylix.colors.base05}'><b>{}</b></span>";
              days = "<span color='#${config.lib.stylix.colors.base05}'><b>{}</b></span>";
              weeks = "<span color='#${config.lib.stylix.colors.base0D}'><b>W{}</b></span>";
              weekdays = "<span color='#${config.lib.stylix.colors.base05}'><b>{}</b></span>";
              today = "<span color='#${config.lib.stylix.colors.base0D}'><b>^{}</b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
          };
        };

        # "network" = {
        #   format-wifi = " ";
        #   format-ethernet = " ";
        #   format-disconnected = " ";
        #   tooltip-format-disconnected = "Error";
        #   tooltip-format-wifi = "{essid} ({signalStrength}%)  ";
        #   tooltip-format-ethernet = "{ifname} 󰈀 ";
        #   on-click = "wezterm start -e nmtui";
        # };

        "tray" = {
          spacing = 0;
        };

        "custom/expand" = {
          "format" = "";
          "tooltip" = false;
        };
        "custom/endpoint" = {
          "format" = "|";
          "tooltip" = false;
        };
        "group/expand" = {
          "orientation" = "horizontal";
          "drawer" = {
            "transition-duration" = 600;
            "transition-to-left" = true;
            "click-to-reveal" = true;
          };
          "modules" = [
            "custom/expand"
            "cpu"
            "memory"
            "temperature"
            "hyprland/language"
            "custom/endpoint"
            "tray"
            "custom/seperator"
          ];
        };
      };
    };

    style = ''
      @import "colors.css";
      @import "add.css";

      * {
        border: none;
        border-radius: 0;
        padding: 1px 2px 1px 2px;
        font-family: "${config.stylix.fonts.monospace.name}";
        font-size: 11pt;
      }
    '';
  };
}
