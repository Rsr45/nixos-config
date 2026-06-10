{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.yazi = {
    enable = true;
    enableNushellIntegration = true;
    shellWrapperName = "yy";
    plugins = {
      git = pkgs.yaziPlugins.git;
      full-border = pkgs.yaziPlugins.full-border;
      jump-to-char = pkgs.yaziPlugins.jump-to-char;
    };
    initLua = ''
      require("full-border"):setup {
          type = ui.Border.PLAIN
      }

      th.git = th.git or {}
      th.git.modified = ui.Style():fg("blue")
      th.git.deleted = ui.Style():fg("red"):bold()

      th.git = th.git or {}
      th.git.modified_sign = "M"
      th.git.deleted_sign = "D"
      th.git.added_sign = "A"
      th.git.updated_sign = "U"
      th.git.untracked_sign = "??"
      th.git.ignored_sign = "!!"

      require("git"):setup()
    '';
    keymap = {
      # input.prepend_keymap = [
      #   { run = "close"; on = [ "<C-q>" ]; }
      #   { run = "close --submit"; on = [ "<Enter>" ]; }
      #   { run = "escape"; on = [ "<Esc>" ]; }
      #   { run = "backspace"; on = [ "<Backspace>" ]; }
      # ];
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
      indicator = {
        padding = {
          open = "▐";
          close = "▌";
        };
      };
      status = {
        overall = {
          bg = lib.mkForce "#${config.lib.stylix.colors.base01}";
        };
        sep_left = {
          open = "▐";
          close = "▌";
        };
        sep_right = {
          open = "▐";
          close = "▌";
        };
      };
      tabs = {
        sep_inner = {
          open = "▐";
          close = "▌";
        };
        sep_outer = {
          open = "▐";
          close = "▌";
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
