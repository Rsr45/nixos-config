{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
  mkMenu =
    menu:
    let
      configFile = pkgs.writeText "config.yaml" (
        pkgs.lib.generators.toYAML { } {
          anchor = "bottom-right";
          background = "#${config.lib.stylix.colors.base00}";
          color = "#${config.lib.stylix.colors.base05}";
          border = "#${config.lib.stylix.colors.base04}";
          separator = " : ";
          border_width = 2;
          corner_r = 0;
          padding = 15; # Defaults to corner_r
          column_padding = 25; # Defaults to padding

          # ...
          inherit menu;
        }
      );
    in
    pkgs.writeShellScriptBin "my-menu" ''
      exec ${pkgs.lib.getExe pkgs.wlr-which-key} ${configFile}
    '';
in
{
  # xdg.configFile."uwsm/env".source =
  #   "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = false;
    configType = "hyprlang";
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # portalPackage =
    #   inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    plugins = [
      # inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
      # inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
      # inputs.hyprland-plugins.packages.${pkgs.system}.borders-plus-plus
    ];
    settings = {
      "$mod" = "SUPER";
      "exec-once" = [
        # "eww daemon; eww open bar_1"
        # "uwsm app -- qs -d --config ${config.xdg.configHome}/qs-dwm" # launched via sytemd through qs home module
        "uwsm app -- noctalia-shell"
        # "uwsm app -- awww restore" # use noctalia-shell
        ## Fix Soteria Polkit Agent
        # "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_ID" # supposed to be set up by uwsm so use them without uwsm
        # "waybar"
        # "waybar -c ~/.config/waybar/waybar_block_1/config.jsonc -s ~/.config/waybar/waybar_block_1/style.css"
        # "waybar -c ~/.config/waybar/suckless_underline/config.jsonc -s ~/.config/waybar/suckless_underline/style.css"
        # "copyq --start-server"
      ];
      source = [
        "colors.conf"
      ];
      monitor = [ ",1920x1080@144,auto,1" ];
      input = {
        kb_layout = "us";

        kb_options = "compose:menu";
        # kb_variant = "";
        numlock_by_default = true;
        resolve_binds_by_sym = 1;
        repeat_delay = 660;
        repeat_rate = 25;
        accel_profile = "flat";
        follow_mouse = 1;
      };
      general = {
        gaps_in = 10;
        gaps_out = 10;
        # gaps_in = 0;
        # gaps_out = 0;
        border_size = 2;
        layout = "dwindle";
        # resize_on_border = true;
      };
      decoration = {
        rounding = config.hostSpec.cornerRadius;
        # active_opacity = 0.9;
        # inactive_opacity = 0.9;
        dim_inactive = false;
        dim_strength = 0.2;
        blur = {
          enabled = false;
          # ignore_opacity = true;
          # popups = true;
          # size = 8;
          # passes = 2;
          size = 3;
          passes = 2;
          vibrancy = 0.1696;
        };

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          # color = "rgba(1a1a1aee)";
        };
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
        # vfr = 1;
        # vrr = 1;
        # layers_hog_mouse_focus = true
        focus_on_activate = true;
        animate_manual_resizes = false;
        animate_mouse_windowdragging = false;
        enable_swallow = true;
        swallow_regex = "(foot|kitty|org.wezfurlong.wezterm|com.mitchellh.ghostty)";

        disable_hyprland_logo = true;
        # new_window_takes_over_fullscreen = 2;
      };
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      bindel = [
        ", XF86AudioRaiseVolume, exec, uwsm app -- wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, uwsm app -- wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];
      bindl = [
        ", XF86AudioMute, exec, uwsm app -- wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, uwsm app -- playerctl play-pause"
        ", XF86AudioPrev, exec, uwsm app -- playerctl previous"
        ", XF86AudioNext, exec, uwsm app -- playerctl next"
      ];
      bind = [
        "$mod, left, movefocus, l"
        "$mod, k, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod+Shift, left, movewindow, l"
        "$mod+Shift, k, movewindow, l"
        "$mod+Shift, right, movewindow, r"
        "$mod+Shift, up, movewindow, u"
        "$mod+Shift, down, movewindow, d"

        "$mod, Q, killactive,"
        "$mod+Shift+Alt, Q, exec, uwsm app -- hyprctl kill"

        "$mod+SHIFT, Space, togglefloating,"
        "$mod+ALT, F, fullscreenstate, 0 3"
        "$mod, F, fullscreen, 0"
        "$mod, M, fullscreen, 1"

        "$mod, 0, workspace, 10"
        "$mod SHIFT, 0, movetoworkspace, 10"

        "$mod, N, togglespecialworkspace, special"
        "$mod SHIFT, N, movetoworkspace, special"

        ", Print, exec, uwsm app -- bash -c 'FILE='$HOME/Pictures/Screenshots/Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png'; grim - | tee '$FILE' | wl-copy --type image/png'"
        "$mod SHIFT, S, exec, uwsm app -- bash -c 'FILE='$HOME/Pictures/Screenshots/Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png'; grim -g '$(slurp)' - | tee '$FILE' | wl-copy --type image/png'"

        "$mod SHIFT, C, exec, uwsm app -- hyprpicker -a -f hex"
        "$mod+Alt, W, exec, uwsm app -- noctalia-shell ipc call wallpaper toggle"
        "$mod, O, exec, uwsm app -- ~/scripts/ocr.sh"
        "$mod, B, exec, uwsm app -- ~/scripts/bookmarks.sh"
        "$mod, D, exec, uwsm app -- bemenu-run"
        # "$mod, Space, exec, rofi -show drun || pkill rofi"
        "$mod, Space, exec, uwsm app -- vicinae toggle"
        "$mod, Return, exec, uwsm app -- dolphin"
        "$mod, T, exec, uwsm app -- wezterm"
        "$mod, A, exec, uwsm app -- ~/scripts/mixer.sh"
        # "$mod, E, exec, wezterm start --class dired -- yazi"
        "$mod, L, exec, uwsm app -- noctalia-shell ipc call lockScreen lock"
        "$mod, Delete, exec, uwsm app -- noctalia-shell ipc call sessionMenu toggle"
        # "$mod, Print, exec, uwsm app -- wlr-which-key"
        # (
        #   "$mod, G, exec, "
        #   + lib.getExe (mkMenu [
        #     {
        #       key = "t";
        #       desc = "next tab";
        #       cmd = "hyprctl dispatch workspace +1";
        #     }
        #     {
        #       key = "T";
        #       desc = "prev tab";
        #       cmd = "hyprctl dispatch workspace -1";
        #     }
        #     {
        #       key = "o";
        #       desc = "Off";
        #       cmd = "poweroff";
        #     }
        #   ])
        # )
      ]
      ++ (builtins.concatLists (
        builtins.genList (
          i:
          let
            ws = i + 1;
          in
          [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        ) 9
      ));
      windowrule = [
        # "float, class:(waypaper)"
        # "float, class:(com.saivert.pwvucontrol)"
        # "float, class:(xdg-desktop-portal-gtk)"
        "float on, size 622 652, stay_focused on, match:class ^(mixer)$"
        # "float, workspace:0"
        # "size 815 600, class:(com.saivert.pwvucontrol) "
        # "size 360 660, class:(io.bassi.Amberol)"
        # "size 800 600, class:(kitty)"
        "float on, match:title ^(Picture-in-Picture)$"
        # "pin, title:^(Picture-in-Picture)$"
        # "workspace special silent, class:org.keepassxc.KeePassXC"
        # "border_size 0, match:workspace w[t1]"
        "float on, size 622 652, stay_focused on, match:class ^(com.github.hluk.copyq)$"
      ];
      layerrule = [
        # "blur, waybar"
        # "blur, quickshell"
        # "ignorealpha x, waybar"
        "blur on, ignore_alpha 0, match:namespace vicinae"
        "no_anim on, match:namespace vicinae"
      ];
    };
    extraConfig = ''
      # bind = SUPER, TAB, hyprexpo:expo, toggle # can be: toggle, off/disable or on/enable
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
