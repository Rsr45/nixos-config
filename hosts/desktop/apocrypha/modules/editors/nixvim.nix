{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    opts = {
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      showmode = false;
      number = true;
      relativenumber = true;
      cursorline = true;
      background = "dark";
    };

    diagnostics = {
      virtual_lines = false;
      virtual_text = false;
      underline = true;
      signs = true;
    };

    clipboard.providers = {
      wl-copy.enable = true;
      xclip.enable = true;
    };

    keymaps = [
      {
        action = "vim.lsp.buf.format()";
        key = "<leader>lf";
      }
      {
        action = "vim.diagnostic.open_float()";
        key = "<leader>ld";
      }
    ];

    extraPlugins = with pkgs.vimPlugins; [
      miasma-nvim
      gruvbox-material
    ];

    plugins = {
      web-devicons.enable = true;
      lualine = {
        enable = true;
      };
      notify = {
        enable = true;
      };

      nvim-tree = {
        enable = true;
      };

      which-key = {
        enable = true;
      };

      intellitab.enable = true;
      comment.enable = true;
      nvim-autopairs.enable = true;
      indent-blankline = {
        enable = true;
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
            ];
          };
          # indent = {
          #   char = "│";
          # };
          # scope = {
          #   show_end = false;
          #   show_exact_scope = true;
          #   show_start = false;
          # };
        };
      };

      fugitive.enable = true;
      gitsigns.enable = true;
      nix.enable = true;
      lsp = {
        enable = true;
        inlayHints = true;
        servers = {
          # # Nix
          # nil_ls.enable = true;
          nixd = {
            enable = true;
            settings = {
              formatting.command = ["alejandra"];
              nixpkgs = {
                expr = "import (builtins.getFlake \"github:Rsr45/nixos-config\").inputs.nixpkgs { }   ";
              };
              options = {
                nixos.expr = "(builtins.getFlake \"github:Rsr45/nixos-config\").nixosConfigurations.apocrypha.options";
                home-manager.expr = "(builtins.getFlake \"github:Rsr45/nixos-config\").nixosConfigurations.apocrypha.options.home-manager.users.type.getSubOptions []";
              };
            };
          };
          # # Lua
          # lua_ls.enable = true;
          # # TypeScript
          # ts_ls.enable = true;
        };
      };
      lsp-format = {
        enable = true;
      };

      treesitter = {
        enable = true;
        nixvimInjections = true;
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            {name = "buffer";}
            {name = "luasnip";}
            {name = "nvim_lsp";}
            {name = "nvim_lua";}
            {name = "path";}
            {name = "treesitter";}
          ];
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          };
          snippet = {
            expand = ''function(args) require('luasnip').lsp_expand(args.body) end'';
          };
        };
      };

      fzf-lua.enable = true;
      harpoon.enable = true;
      oil = {
        enable = true;
        settings = {
          use_default_keymaps = true;
        };
      };

      telescope = {
        enable = true;
        keymaps = {
          "<leader>f" = "find_files";
          "<leader>b" = "buffers";
          "<leader>w" = "live_grep";
        };
      };

      dashboard = {
        enable = true;
        settings = {
          theme = "doom";
          config = {
            header = [
              "                                                                              "
              "=================     ===============     ===============   ========  ========"
              "\\\\ . . . . . . .\\\\   //. . . . . . .\\\\   //. . . . . . .\\\\  \\\\. . .\\\\// . . //"
              "||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\\/ . . .||"
              "|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||"
              "||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||"
              "|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\\ . . . . ||"
              "||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\\_ . .|. .||"
              "|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\\ `-_/| . ||"
              "||_-' ||  .|/    || ||    \\|.  || `-_|| ||_-' ||  .|/    || ||   | \\  / |-_.||"
              "||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \\  / |  `||"
              "||    `'         || ||         `'    || ||    `'         || ||   | \\  / |   ||"
              "||            .===' `===.         .==='.`===.         .===' /==. |  \\/  |   ||"
              "||         .=='   \\_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \\/  |   ||"
              "||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \\/  |   ||"
              "||   .=='    _-'          `-__\\._-'         `-_./__-'         `' |. /|  |   ||"
              "||.=='    _-'                                                     `' |  /==.||"
              "=='    _-'                        N E O V I M                         \\/   `=="
              "\\   _-'                                                                `-_   /"
              " `''                                                                      ``'  "
            ];
            center = [
              {
                action = "Telescope oldfiles";
                desc = "Recently Opened Files";
                icon = "󱪞 ";
                key = "r";
                key_format = "%s";
              }
              {
                action = "Telescope find_files";
                desc = "Find Files           ";
                icon = " ";
                key = "f";
                key_format = "%s";
              }
              {
                action = "Telescope live_grep";
                desc = "Find Words           ";
                icon = " ";
                key = "w";
                key_format = "%s";
              }
            ];
          };
        };
      };
    };
    extraConfigLuaPre = ''
      vim.g.mapleader = ' '
      vim.g.maplocalleader = ' '
      -- vim.opt.background = "dark"
      -- vim.cmd.colorscheme 'miasma'
      -- vim.cmd "let g:gruvbox_material_background = 'hard'"
      -- vim.cmd "let g:gruvbox_material_foreground = 'original'"
    '';
    # extraConfigLua = ''
    #   -- Make line numbers default1
    #   vim.opt.number = true
    #   vim.opt.relativenumber = true
    #
    #   -- Enable mouse mode.
    #   vim.opt.mouse = 'a'
    #
    #   -- Don't show the mode.
    #   vim.opt.showmode = false
    #
    #   -- Enable break indent
    #   vim.opt.breakindent = true
    #
    #   -- Save undo history
    #   vim.opt.undofile = true
    #
    #   -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
    #   vim.opt.ignorecase = true
    #   vim.opt.smartcase = true
    #
    #   -- Keep signcolumn on by default
    #   vim.opt.signcolumn = 'yes'
    #
    #   -- Decrease update time
    #   vim.opt.updatetime = 250
    #
    #   -- Decrease mapped sequence wait time
    #   -- Displays which-key popup sooner
    #   vim.opt.timeoutlen = 300
    #
    #   -- Configure how new splits should be opened
    #   vim.opt.splitright = true
    #   vim.opt.splitbelow = true
    #
    #   -- Sets how neovim will display certain whitespace characters in the editor.
    #   --  See `:help 'list'`
    #   --  and `:help 'listchars'`
    #   vim.opt.list = true
    #   vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
    #
    #   -- Preview substitutions live, as you type!
    #   vim.opt.inccommand = 'split'
    #
    #   -- Show which line your cursor is on
    #   vim.opt.cursorline = true
    #
    #   -- Minimal number of screen lines to keep above and below the cursor.
    #   vim.opt.scrolloff = 10
    #
    #   -- [[ Basic Keymaps ]]
    #   --  See `:help vim.keymap.set()`
    #
    #   -- Clear highlights on search when pressing <Esc> in normal mode
    #   --  See `:help hlsearch`
    #   vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
    #
    #   -- Diagnostic keymaps
    #   vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
    #
    #   -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
    #   -- or just use <C-\><C-n> to exit terminal mode
    #   vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
    #
    #   -- Keybinds to make split navigation easier.
    #   --  Use CTRL+<←↓↑→> to switch between windows
    #   --
    #   --  See `:help wincmd` for a list of all window commands
    #   vim.keymap.set('n', '<C-left>', '<C-w><C-left>', { desc = 'Move focus to the left window' })
    #   vim.keymap.set('n', '<C-right>', '<C-w><C-right>', { desc = 'Move focus to the right window' })
    #   vim.keymap.set('n', '<C-down>', '<C-w><C-down>', { desc = 'Move focus to the lower window' })
    #   vim.keymap.set('n', '<C-up>', '<C-w><C-up>', { desc = 'Move focus to the upper window' })
    # '';
    # extraConfigLuaPost = '''';
  };
}
