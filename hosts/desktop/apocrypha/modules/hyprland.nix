{
  config,
  inputs,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = false;
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
    ];
    settings = {
      "$mod" = "SUPER";
      monitor = [",1920x1080@144,auto,1"];
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 4;
        layout = "dwindle";
        resize_on_border = true;
        "col.active_border" = "rgb(282828)";
        "col.inactive_border" = "rgb(282828)";
      };
      "exec-once" = [
        "eww daemon & eww open bar_1"
        "dunst"
        "swww kill; swww-daemon"
      ];
      input = {
        # Keyboard: Add a layout and uncomment kb_options for Win+Space switching shortcut
        kb_layout = "tr";
        # kb_options = grp:win_space_toggle;
        numlock_by_default = true;
        repeat_delay = 250;
        repeat_rate = 35;
        accel_profile = "flat";

        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          clickfinger_behavior = true;
          scroll_factor = 0.5;
        };

        # special_fallthrough = true   # only in new hyprland versions. but they're hella fucked
        follow_mouse = 1;
      };
      decoration = {
        rounding = 12;
        rounding_power = 2.0;
        dim_inactive = true;

        # Shadow
        # drop_shadow = false;
        # shadow_ignore_window = true;
        # shadow_range = 20;
        # shadow_offset = "0 2";
        # shadow_render_power = 2;
        # "col.shadow" = "rgba(0000001A)";
      };
      animations = {
        enabled = false;
        bezier = [
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92"
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "fluent_decel, 0.1, 1, 0, 1"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
        ];
        animation = [
          "windows, 1, 3, md3_decel, popin 60%"
          "border, 1, 10, default"
          "fade, 1, 2.5, md3_decel"
          # "workspaces, 1, 3.5, md3_decel, slide"
          "workspaces, 1, 7, fluent_decel, slide"
          # "workspaces, 1, 7, fluent_decel, slidefade 15%"
          # "specialWorkspace, 1, 3, md3_decel, slidefadevert 15%"
          "specialWorkspace, 1, 3, md3_decel, slidevert"
        ];
      };
      plugin = {
        hyprbars = {
          bar_text_font = "IBM Plex Serif";
          bar_height = "30";
          bar_padding = "10";
          bar_button_padding = "5";
          bar_precedence_over_border = "true";
          bar_part_of_window = "true";

          bar_color = "rgba(282828FF)";
          col.text = "rgba(FBF1C7FF)";
        };
      };
      misc = {
        vfr = 1;
        vrr = 1;
        # layers_hog_mouse_focus = true
        focus_on_activate = true;
        animate_manual_resizes = false;
        animate_mouse_windowdragging = false;
        enable_swallow = true;
        swallow_regex = "(foot|kitty|allacritty|Alacritty|org.wezfurlong.wezterm)";

        disable_hyprland_logo = true;
        new_window_takes_over_fullscreen = 2;
      };
      debug = {
        # overlay = true;
        # damage_tracking = 0;
        # damage_blink = true;
      };
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];
      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"
      ];
      bind = [
        # # # Window management
        # # Focusing
        # # bind = Super, ←/↑/→/↓,, # Move focus in direction
        "$mod, Left, movefocus, l"
        "$mod, Right, movefocus, r"
        "$mod, Up, movefocus, u"
        "$mod, Down, movefocus, d"
        "$mod+Shift, Q, killactive,"
        "$mod+Shift+Alt, Q, exec, hyprctl kill" # Pick and kill a window
        # # Window arrangement
        # # bind = Super+Shift, ←/↑/→/↓,, # Window: move in direction
        "$mod+Shift, Left, movewindow, l"
        "$mod+Shift, Right, movewindow, r"
        "$mod+Shift, Up, movewindow, u"
        "$mod+Shift, Down, movewindow, d"
        # # Positioning mode
        "$mod+Alt, Space, togglefloating,"
        "$mod+Alt, F, fullscreenstate, 0 3" # Toggle fake fullscreen
        "$mod, F, fullscreen, 0"
        "$mod, D, fullscreen, 1"
        # # Workspaces
        # "$mod, 1, workspace, 1"
        # "$mod, 2, workspace, 2"
        # "$mod, 3, workspace, 3"
        # "$mod, 4, workspace, 4"
        # "$mod, 5, workspace, 5"
        # "$mod, 6, workspace, 6"
        # "$mod, 7, workspace, 7"
        # "$mod, 8, workspace, 8"
        # "$mod, 9, workspace, 9"
        # "$mod, 0, workspace, 10"
        # "$mod SHIFT, 1, movetoworkspace, 1"
        # "$mod SHIFT, 2, movetoworkspace, 2"
        # "$mod SHIFT, 3, movetoworkspace, 3"
        # "$mod SHIFT, 4, movetoworkspace, 4"
        # "$mod SHIFT, 5, movetoworkspace, 5"
        # "$mod SHIFT, 6, movetoworkspace, 6"
        # "$mod SHIFT, 7, movetoworkspace, 7"
        # "$mod SHIFT, 8, movetoworkspace, 8"
        # "$mod SHIFT, 9, movetoworkspace, 9"
        # "$mod SHIFT, 0, movetoworkspace, 10"
        # "$mod, mouse_down, workspace, e+1"
        # "$mod, mouse_up, workspace, e-1"
        # # Special Workspaces
        "$mod, S, togglespecialworkspace, magic"
        "$mod ALT, S, movetoworkspace, special:magic"
        "$mod, i, togglespecialworkspace, special"
        # # # Actions
        # # Color Picker
        "$mod SHIFT, C, exec, hyprpicker -a -f hex"
        # # Wallpaper
        "$mod+Alt, W, exec, pkill waypaper || waypaper"
        # # App Launcer
        "$mod, Space, exec, pkill fuzzel || fuzzel"
        # # -______Terminal______- # #
        "$mod, Return, exec, kitty"
        # # File Explorer
        "$mod, T, exec, nemo"
        # # Power Off etc.
        "Ctrl+Shift+Super, Delete, exec, systemctl reboot" # Restart
        "Ctrl+Shift+Alt+Super, Delete, exec, systemctl poweroff || loginctl poweroff" # Power off
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (
          i: let
          ws = i + 1;
          in [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        )
        9)
      );
      windowrulev2 = [
        "float, class:(waypaper)"
        "float, workspace:10"
      ];
    };
    extraConfig = ''
      plugin {
        hyprexpo {
          columns = 3
          gap_size = 5
          bg_col = rgb(000000)
          workspace_method = first 1 # [center/first] [workspace] e.g. first 1 or center m+1

          enable_gesture = false # laptop touchpad, 4 fingers
          gesture_distance = 300 # how far is the "max"
          gesture_positive = false
        }
      }

      bind = SUPER, TAB, hyprexpo:expo, toggle # can be: toggle, off/disable or on/enable
      bind = , Print, exec, grim - | wl-copy && wl-paste > ~/Pictures/Screenshots/$(date +'Screenshot_%F_%T.png') | dunstify "Screenshot of whole screen taken" -t 1000
      bind = $mod SHIFT, S, exec, grim -g "$(slurp)" - | wl-copy && wl-paste > ~/Pictures/Screenshots/$(date +'Screenshot_%F_%T.png') | dunstify "Screenshot of the region taken" -t 1000
    '';
  };
}
