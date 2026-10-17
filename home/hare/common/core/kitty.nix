{...}: {
  # home.packages = [ pkgs.kitty-termi ];
  programs.kitty = {
    enable = true;
    shellIntegration.mode = "no-sudo";
    # font = {
    #   size = 12;
    #   name = "Iosevka";
    #   # package = pkgs.geist;
    # };
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
      "ctrl+shift+t" = "no_op";
      "ctrl+shift+r" = "no_op";
      "ctrl+shift+d" = "no_op";
      "ctrl+shift+l" = "no_op";
    };
    settings = {
      # include = "./generated-colors.conf"; # using stylix my boi again just like the old times
      allow_remote_control = "yes";
      listen_on = "unix:kitty";
      # text_composition_strategy = "legacy";
      confirm_os_window_close = "0";
      window_padding_width = "6";
      placement_strategy = "center";
      shell = "zsh";
      # notify_on_cmd_finish = "unfocused";
    };
  };
}
