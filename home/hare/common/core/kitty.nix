{ pkgs, ... }:
{
  home.packages = [ pkgs.kitty ];
  programs.kitty = {
    enable = true;
    font = {
      size = 12;
      name = "Iosevka";
      # package = pkgs.geist;
    };
    keybindings = {
      # XF86Copy (0x1008ff57)
      "0x1008ff57" = " copy_to_clipboard";
      # XF86Copy (0x1008ff58)
      "0x1008ff58" = " copy_to_clipboard";
      # XF86Paste (0x1008ff6dx)
      "0x1008ff6d" = "paste_from_clipboard";
      "page_up" = "scroll_page_up";
      "page_down " = "scroll_page_down";
      # "home" = "scroll_home";
      # "end" = "scroll_end";
    };
    settings = {
      include = "./generated-colors.conf";
      # text_composition_strategy = "legacy";
      confirm_os_window_close = "0";
      window_padding_width = "6";
      placement_strategy = "center";
      shell = "fish";
      notify_on_cmd_finish = "unfocused";
    };
  };
}
