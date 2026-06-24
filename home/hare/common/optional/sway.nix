{
  lib,
  config,
  ...
}: {
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    checkConfig = true;
    config = let
      modifier = config.wayland.windowManager.sway.config.modifier;
    in {
      modifier = "Mod4";
      terminal = "alacritty";
      startup = [
        {command = "awww restore";}
        {command = "qs -d -c ~/.config/qs-dwm";}
      ];

      keybindings = lib.mkOptionDefault {
        "${modifier}+t" = "exec alacritty";
        "${modifier}+Return" = "exec dolphin";
        "${modifier}+space" = "exec vicinae toggle";
        # "${modifier}+space" = "exec rofi -show drun || pkill rofi";

        "Print" = " exec screenshot-full";
        "${modifier}+Shift+S" = " exec screenshot-region";
        "${modifier}+C" = " exec colorpicker";
        "${modifier}+Shift+R" = " exec screenshot-ocr";
        "${modifier}+Shift+P" = " exec bookmarks";
        "${modifier}+Shift+W" = " exec wallpaper-picker";

        "XF86AudioPrev" = " exec playerctl previous";
        "XF86AudioNext" = " exec playerctl next";
        "XF86AudioPlay" = " exec playerctl play-pause";
        "XF86AudioMute" = " exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86AudioRaiseVolume" = " exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume" = " exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
      };
      bars = [
        (
          {
            mode = "invisible";
            statusCommand = "i3status-rs config-bottom";
          }
          // config.stylix.targets.sway.exportedBarConfig
        )
      ];
      floating.criteria = [
        {
          class = "chat-simplex-desktop-MainKt";
        }
      ];
    };
  };
}
