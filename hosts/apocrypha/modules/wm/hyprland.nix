{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = false;
    plugins = [
      # inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
      # inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
      # inputs.hyprland-plugins.packages.${pkgs.system}.borders-plus-plus
    ];
    settings = {
      "$mod" = "SUPER";
      "exec-once" = [
        # "systemctl --user enable --now hyprpolkitagent.service"
        # "eww daemon; eww open bar_1"
        "uwsm app -- waybar"
        "uwsm app -- dunst"
        "uwsm app -- waypaper --restore --backend swww"
      ];
      monitor = [ ",1920x1080@144,auto,1" ];
      input = {
        kb_layout = "us";
        kb_variant = "colemak_dh_wide_iso";
        kb_options = "caps:swapescape";
        numlock_by_default = true;
        repeat_delay = 250;
        repeat_rate = 45;
        accel_profile = "flat";
        follow_mouse = 1;
      };
      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 0;
        layout = "dwindle";
        resize_on_border = true;
      };
      decoration = {
        rounding = 0;
        rounding_power = 2.0;
        dim_inactive = true;
        dim_strength = 0.2;
      };
      animations = {
        enabled = false;
      };
      # plugin = {
      #   hyprbars = {
      #     bar_text_font = "IBM Plex Serif";
      #     bar_height = "30";
      #     bar_padding = "10";
      #     bar_button_padding = "5";
      #     bar_precedence_over_border = "true";
      #     bar_part_of_window = "true";
      #
      #     bar_color = "rgb(282828)";
      #     "col.text" = "rgb(FBF1C7)";
      #   };
      #   borders-plus-plus = {
      #     add_borders = "1"; # 0 - 9
      #
      #     # you can add up to 9 borders
      #     "col.border_1" = "rgb(1D2021)";
      #
      #     # -1 means "default" as in the one defined in general:border_size
      #     border_size_1 = "-1";
      #
      #     # makes outer edges match rounding of the parent. Turn on / off to better understand. Default = on.
      #     natural_rounding = "yes";
      #   };
      #   hyprexpo = {
      #     columns = "3";
      #     gap_size = "5";
      #     bg_col = "rgb(000000)";
      #     workspace_method = "first 1"; # [center/first] [workspace] e.g. first 1 or center m+1
      #
      #     enable_gesture = "false"; # laptop touchpad, 4 fingers
      #     gesture_distance = "300"; # how far is the "max"
      #     gesture_positive = "false";
      #   };
      # };
      misc = {
        vfr = 1;
        vrr = 1;
        # layers_hog_mouse_focus = true
        focus_on_activate = true;
        animate_manual_resizes = false;
        animate_mouse_windowdragging = false;
        enable_swallow = true;
        swallow_regex = "(foot|kitty|allacritty|Alacritty|org.wezfurlong.wezterm|com.mitchellh.ghostty)";

        disable_hyprland_logo = true;
        new_window_takes_over_fullscreen = 2;
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
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod, Q, killactive,"
        "$mod+Shift+Alt, Q, exec, hyprctl kill"
        "$mod+Shift, left, movewindow, l"
        "$mod+Shift, right, movewindow, r"
        "$mod+Shift, up, movewindow, u"
        "$mod+Shift, down, movewindow, d"
        "$mod+SHIFT, Space, togglefloating,"
        "$mod+ALT, F, fullscreenstate, 0 3"
        "$mod, F, fullscreen, 0"
        "$mod+SHIFT, F, fullscreen, 1"
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
        "$mod, S, togglespecialworkspace, magic"
        "$mod ALT, S, movetoworkspace, special:magic"
        # "$mod, i, togglespecialworkspace, special"
        "$mod SHIFT, C, exec, uwsm app -- hyprpicker --a --f hex"
        "$mod+Alt, W, exec, uwsm app -- waypaper"
        "$mod, Space, exec, uwsm app -- pkill fuzzel || fuzzel"
        "$mod, D, exec, uwsm app -- bemenu-run"
        "$mod, Return, exec, uwsm app -- wezterm"
        "$mod, T, exec, uwsm app -- nemo"
        "$mod SHIFT, E, exec, hyprctl dispatch exit 1"
        "Ctrl+Shift+Super, Delete, exec, systemctl reboot"
        "Ctrl+Shift+Alt+Super, Delete, exec, systemctl poweroff || loginctl poweroff"
      ];
      windowrulev2 = [
        "float, class:(waypaper)"
        "float, class:(com.saivert.pwvucontrol)"
        "float, class:(xdg-desktop-portal-gtk)"
        "size 815 600, class:(com.saivert.pwvucontrol) "
        "size 360 660, class:(io.bassi.Amberol)"
        "size 800 600, class:(kitty)"
      ];
    };
    extraConfig = ''
      # bind = SUPER, TAB, hyprexpo:expo, toggle # can be: toggle, off/disable or on/enable
      bind = , Print, exec, grim - | wl-copy && wl-paste > ~/Pictures/Screenshots/$(date +'Screenshot_%F_%T.png')
      bind = $mod SHIFT, S, exec, grim -g "$(slurp)" - | wl-copy && wl-paste > ~/Pictures/Screenshots/$(date +'Screenshot_%F_%T.png') | dunstify "Screenshot of the region taken" -t 1000
      # will switch to a submap called resize
      bind = $mod, R, submap, resize

      # will start a submap called "resize"
      submap = resize

      # sets repeatable binds for resizing the active window
      binde = , right, resizeactive, 10 0
      binde = , left, resizeactive, -10 0
      binde = , up, resizeactive, 0 -10
      binde = , down, resizeactive, 0 10

      # use reset to go back to the global submap
      bind = , escape, submap, reset
      bind = $mod, R, submap, reset

      # will reset the submap, which will return to the global submap
      submap = reset
    '';
  };
}
