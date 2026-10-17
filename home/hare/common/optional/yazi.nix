{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.yazi = {
    enable = true;
    plugins = {
      jump-to-char = pkgs.yaziPlugins.jump-to-char;
    };
    initLua = ''
    '';
    keymap = {
      mgr.prepend_keymap = [
        {
          run = "plugin jump-to-char";
          on = ["f"];
        }
        # { run = "quit"; on = [ "q" ]; }
        # { run = "close"; on = [ "<C-q>" ]; }
      ];
    };
    theme = {
      mgr = {
        border_symbol = " ";
      };
      indicator = {
        padding = {
          open = "▐";
          close = "▌";
        };
      };
      status = {
        # overall = {
        #   bg = lib.mkForce "#${config.lib.stylix.colors.base01}";
        # };
        sep_left = {
          open = "";
          close = "";
        };
        sep_right = {
          open = "";
          close = "";
        };
      };
      tabs = {
        sep_inner = {
          open = "";
          close = "";
        };
        sep_outer = {
          open = "";
          close = "";
        };
      };
    };
    settings = {
      log = {
        enabled = false;
      };
      mgr = {
        show_hidden = false;
        sort_by = "alphabetical";
        sort_dir_first = true;
        sort_reverse = false;
        linemode = "size";
      };
    };
  };
}
