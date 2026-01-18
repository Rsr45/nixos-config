{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.nixvim.plugins = {
    indent-blankline = {
      enable = false;
      settings = {
        exclude = {
          buftypes = [
            "terminal"
            "quickfix"
          ];
          filetypes = [
            ""
            "checkhealth"
            "help"
            "lspinfo"
            "packer"
            "dashboard"
            "TelescopePrompt"
            "TelescopeResults"
            "yaml"
            "Trouble"
            "alpha"
            "dashboard"
            "help"
            "lazy"
            "mason"
            "neo-tree"
            "notify"
            "snacks_dashboard"
            "snacks_notif"
            "snacks_terminal"
            "snacks_win"
            "toggleterm"
            "trouble"
          ];
        };
        indent = {
          char = "▏";
        };
        scope = {
          enabled = true;
          show_end = false;
          show_exact_scope = true;
          show_start = false;
        };
      };
    };
  };
}
