{
  pkgs,
  ...
}:

{
  imports = [
    ./plugins/mini.nix
    ./plugins/mini-clue.nix
    # ./plugins/mini-jump2d.nix
    ./plugins/flash.nix
    ./plugins/picker.nix
    ./plugins/oil.nix
    ./plugins/snacks.nix
    ./plugins/obsidian.nix
    # ./plugins/norg.nix
    ./plugins/org.nix
    ./plugins/icons.nix
    ./plugins/git.nix
  ];

  programs.nixvim = {
    plugins = {
      render-markdown = {
        enable = true;
        settings = {
          bullet = {
            # icons = [
            #   "◆ "
            #   "• "
            #   "• "
            # ];
            enabled = true;
            render_modes = false;
            icons = [
              "󰫶 "
              "󱂉 "
            ];
            ordered_icons.__raw = ''
              function(ctx)
                  local value = vim.trim(ctx.value)
                  local index = tonumber(value:sub(1, #value - 1))
                  return ('%d.'):format(index > 1 and index or ctx.index)
              end
            '';
            left_pad = 0;
            right_pad = 0;
            highlight = "RenderMarkdownBullet";
            scope_highlight = { };
            scope_priority = "nil";
          };
          code = {
            above = " ";
            below = " ";
            border = "thick";
            language_pad = 2;
            left_pad = 2;
            position = "right";
            right_pad = 2;
            sign = false;
            width = "block";
          };
          heading = {
            border = false;
            icons = [
              "▼ "
              "▽ "
              "▼ "
              "▽ "
              "▼ "
              "▽ "
            ];
            position = "inline"; # inline, overlay
            sign = false;
            width = "full";
            backgrounds = [
              ""
              ""
              ""
              ""
              ""
              ""
            ];
          };
          render_modes = true;
          indent = {
            enabled = true;
            skip_heading = false;
            highlight = "";
            icon = "";
          };
          signs = {
            enabled = false;
          };
        };
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      miasma-nvim
      dracula-nvim
      vim-moonfly-colors
      gruvbox-nvim
      gruvbox-material
      pywal-nvim
      doom-one-nvim

      (pkgs.vimUtils.buildVimPlugin {
        name = "neopywal";
        src = pkgs.fetchurl {
          url = "https://github.com/RedsXDD/neopywal.nvim/archive/refs/tags/v2.6.0.tar.gz";
          hash = "sha256-NkG+Ek5RdSc+HdBAmJG+833JzDeOLvXkKVm4xXdjb9s=";
        };
      })
    ];
  };
}
