{ config, ... }:
{
  programs.sioyek = {
    enable = true;
    bindings = {
      "move_up" = "Up";
      "move_down" = "Down";
      "move_left" = "Left";
      "move_right" = "Right";
      "screen_down" = [
        "<C-d>"
      ];
      "screen_up" = [
        "<C-u>"
      ];
    };
    config = {
      "background_color" = "1.0 1.0 1.0";
      "text_highlight_color" = "1.0 0.0 0.0";
      "source" = "${config.xdg.configHome}/sioyek/colors";
    };
  };
}
