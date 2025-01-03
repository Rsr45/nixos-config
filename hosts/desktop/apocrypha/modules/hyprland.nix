{
  config,
  inputs,
  pkgs,
  ...
}: {
  # # Hyprland Settings
  # class                 border  bground text    indicator child_border
  # client.focused          #fabd2f #1d2021 #fabd2f #83CAFA   #fabd2f
  # client.focused_inactive #8C8C8C #4C4C4C #FFFFFF #4C4C4C   #8C8C8C
  # client.unfocused        #4C4C4C #141617 #888888 #292D2E   #222222
  # client.urgent           #EC69A0 #DB3279 #FFFFFF #DB3279   #DB3279
  # client.placeholder      #000000 #0C0C0C #FFFFFF #000000   #0C0C0C
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      "$mod" = "SUPER";
      monitor = [",1920x1080@144,auto,1"];
      general = {
        gaps_in = 0;
        gaps_out = 0;
        # gaps_workspaces = 50;
        border_size = 4;
        layout = "dwindle";
        resize_on_border = true;
        # # Miasma.
        # "col.active_border" = "rgb(b36d43)";
        # "col.inactive_border" = "rgb(4c4c4c)";
        # # Gruvbox Hard.
        # "col.active_border" = "rgb(fabd2f)";
        # "col.inactive_border" = "rgb(4c4c4c)";
        # # Zen
        "col.active_border" = "rgb(161616)";
        "col.inactive_border" = "rgb(131313)";
      };
      dwindle = {
        preserve_split = true;
        smart_resizing = false;
      };
      "exec-once" = [
        # "ags -c /home/hare/.config/ags/simple-bar/config.js"
        "eww daemon & eww open bar_1"
        "dunst"
        # "waybar -b verticalBar"
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
        rounding = 0;

        blur = {
          enabled = true;
          xray = true;
          special = false;
          new_optimizations = true;
          size = 5;
          passes = 4;
          brightness = 1;
          noise = 1.0e-2;
          contrast = 1;
        };
        # Shadow
        drop_shadow = false;
        shadow_ignore_window = true;
        shadow_range = 20;
        shadow_offset = "0 2";
        shadow_render_power = 2;
        "col.shadow" = "rgba(0000001A)";

        # Dim
        dim_inactive = false;
        dim_strength = 0.1;
        dim_special = 0;
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
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
        # # Special Workspaces
        "$mod, S, togglespecialworkspace, magic"
        "$mod ALT, S, movetoworkspace, special:magic"
        # # # Actions
        # # Color Picker
        "$mod SHIFT, C, exec, hyprpicker -a -f hex"
        # # Wallpaper
        "$mod+Alt, W, exec, pkill waypaper || waypaper"
        # # App Launcer
        "$mod, Space, exec, pkill fuzzel || fuzzel"
        # # Terminal
        "$mod, Return, exec, alacritty"
        # "$mod, Return, exec, wezterm"
        # # File Explorer
        "$mod, T, exec, thunar"
        # # Power Off etc.
        "Ctrl+Shift+Super, Delete, exec, systemctl reboot" # Restart
        "Ctrl+Shift+Alt+Super, Delete, exec, systemctl poweroff || loginctl poweroff" # Power off
      ];
      windowrulev2 = [
        "float, class:(waypaper)"
        "float, workspace:10"
      ];
    };
    extraConfig = ''
      # # Resizing(like i3)
      bind = $mod, R, submap,resize
      submap = resize
      binde=,Right,resizeactive,  40 0
      binde=,Left,resizeactive, -40 0
      binde=,Up,resizeactive,   0 -40
      binde=,Down,resizeactive,   0 40
      bind = ,escape, submap, reset
      bind = ,return,  submap, reset
      submap = reset

      bind = , Print, exec, grim - | wl-copy && wl-paste > ~/Pictures/Screenshots/$(date +'Screenshot_%F_%T.png') | dunstify "Screenshot of whole screen taken" -t 1000
      bind = $mod SHIFT, S, exec, grim -g "$(slurp)" - | wl-copy && wl-paste > ~/Pictures/Screenshots/$(date +'Screenshot_%F_%T.png') | dunstify "Screenshot of the region taken" -t 1000
    '';
  };
}
