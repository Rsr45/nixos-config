{
  pkgs,
  inputs,
  config,
  ...
}:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
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
      # background = "dark";
    };

    colorscheme = "kanagawa";
    colorschemes.kanagawa.enable = true;
    colorschemes.kanagawa.settings = {
      commentStyle = {
        italic = false;
      };
      compile = false;
      dimInactive = false;
      functionStyle = { };
      overrides = "function(colors) return {} end";
      terminalColors = true;
      theme = "dragon";
      background = {
        dark = "dragon";
        light = "lotus";
      };
      transparent = true;
      undercurl = true;
    };

    diagnostics.settings = {
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
      ## Flash
      {
        key = "s";
        mode = [
          "n"
          "x"
          "o"
        ];
        action = "<cmd>lua require(\"flash\").jump()<cr>";
      }
      {
        key = "S";
        mode = [
          "n"
          "x"
          "o"
        ];
        action = "<cmd>lua require(\"flash\").treesitter()<cr>";
      }
      {
        key = "r";
        mode = [
          "o"
        ];
        action = "<cmd>lua require(\"flash\").remote()<cr>";
      }
      {
        key = "R";
        mode = [
          "x"
          "o"
        ];
        action = "<cmd>lua require(\"flash\").treesitter_search()<cr>";
      }
      {
        key = "<C-s>";
        mode = [
          "c"
        ];
        action = "<cmd>lua require(\"flash\").toggle()<cr>";
      }
      ## Quality of Life
      {
        key = "<S-Down>";
        mode = "v";
        action = ":m '>+1<CR>gv=gv";
        options.desc = "Moves Line Down";
      }
      {
        key = "<S-Up>";
        mode = "v";
        action = ":m '<-2<CR>gv=gv";
        options.desc = "Moves Line Up";
      }
      {
        key = "<C-d>";
        mode = "n";
        action = "<C-d>zz";
        options.desc = "Scroll Down";
      }
      {
        key = "<C-u>";
        mode = "n";
        action = "<C-u>zz";
        options.desc = "Scroll Up";
      }
      {
        key = "n";
        mode = "n";
        action = "nzzzv";
        options.desc = "Next Search Result";
      }
      {
        key = "N";
        mode = "n";
        action = "Nzzzv";
        options.desc = "Previous Search Result";
      }
      {
        key = "<Down>";
        mode = "n";
        action = "v:count == 0 ? 'gj' : 'j'";
        options = {
          expr = true;
          silent = true;
        };
      }
      {
        key = "<Up>";
        mode = "n";
        action = "v:count == 0 ? 'gk' : 'k'";
        options = {
          expr = true;
          silent = true;
        };
      }
      # ----------- Clipbord -----------------
      {
        key = "<leader>y";
        mode = [
          "n"
          "x"
          "v"
        ];
        action = "\"+y";
        options = {
          noremap = true;
          silent = true;
          desc = "Yank to clipboard";
        };
      }
      {
        key = "<leader>Y";
        mode = [
          "n"
          "x"
          "v"
        ];
        action = "\"+yy";
        options = {
          noremap = true;
          silent = true;
          desc = "Yank line to clipboard";
        };
      }
      {
        key = "<C-a>";
        mode = [
          "n"
          "x"
          "v"
        ];
        action = "gg0vG$";
        options = {
          noremap = true;
          silent = true;
          desc = "Select All";
        };
      }
      {
        key = "<leader>p";
        mode = [
          "n"
          "x"
          "v"
        ];
        action = "\"+p";
        options = {
          noremap = true;
          silent = true;
          desc = "Paste from clipboard";
        };
      }
      {
        key = "<C-p>";
        mode = "i";
        action = "<C-r><C-p>+";
        options = {
          noremap = true;
          silent = true;
          desc = "Paste from clipboard within insert mode";
        };
      }
      {
        key = "<leader>P";
        mode = "x";
        action = "\"_dP";
        options = {
          noremap = true;
          silent = true;
          desc = "Paste over selection without erasing unnamed register";
        };
      }
      ## Buffer
      {
        key = "<leader><leader>[";
        mode = "n";
        action = "<cmd>bprev<CR>";
        options.desc = "Previous Buffer";
      }
      {
        key = "<leader><leader>]";
        mode = "n";
        action = "<cmd>bnext<CR>";
        options.desc = "Next Buffer";
      }
      {
        key = "<leader><leader>l";
        mode = "n";
        action = "<cmd>b#<CR>";
        options.desc = "Last Buffer";
      }
      {
        key = "<leader><leader>d";
        mode = "n";
        action = "<cmd>bdelete<CR>";
        options.desc = "Delete Buffer";
      }
      ## Diagnostic
      # {
      #   key = "d";
      #   mode = "n";
      #   action = "<cmd>bdelete<CR>";
      #   options.desc = "Delete Buffer";
      # }
    ];

    extraPlugins = with pkgs.vimPlugins; [
      miasma-nvim
      gruvbox-material
      dracula-nvim
      vim-moonfly-colors
      gruvbox-nvim
    ];

    plugins = {
      notify = {
        enable = false;
      };

      which-key = {
        enable = true;
        settings = {
          preset = "helix";
        };
      };

      intellitab.enable = true;
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
              formatting.command = [ "nixfmt" ];
              nixpkgs = {
                expr = ''import ${pkgs.path} {}'';
              };
              options = {
                nixos.expr = ''(builtins.getFlake "path:${builtins.toString inputs.self.outPath}").nixosConfigurations.configname.options'';
                home-manager.expr = ''(builtins.getFlake "path:${builtins.toString inputs.self.outPath}").nixosConfigurations.${config.hostSpec.hostName}.options.home-manager.users.type.getSubOptions []'';
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

      navic = {
        enable = true;
        luaConfig.post = "vim.o.winbar = \"%{%v:lua.require'nvim-navic'.get_location()%}\"";
        settings = {
          highlight = true;
          lsp = {
            auto_attach = true;
          };
        };
      };

      treesitter = {
        enable = true;
        nixvimInjections = true;
      };

      blink-cmp = {
        enable = true;
      };

      highlight-colors.enable = true;
      highlight-colors.settings = {
        render = "virtual";
        virtual_symbol = "■";
        virtual_symbol_position = "inline";
      };

      snacks.enable = true;
      snacks.settings = {
        statuscolumn = {
          enabled = true;
          left = [
            "mark"
            "sign"
          ];
          right = [
            "fold"
            "git"
          ];
        };
        git = {
          enabled = true;
        };
        lazygit = {
          enabled = true;
        };
        notifier = {
          enabled = true;
        };
        image = {
          enabled = true;
        };
        dashboard = {
          enabled = false; # remove lazy dependent startup section
        };
        zen = {
          enabled = true;
        };
      };

      smartcolumn.enable = true;
      flash.enable = true;
      flash.settings = {
        modes.char.jump_labels = true;
      };
      visual-multi.enable = true;

      mini.enable = true;
      mini.modules = {
        comment = { };
        pairs = { };
        bracketed = { };
        operators = { };
        ai = { };
        basics = { };
        surround = {
          mappings = {
            add = "gza";
            delete = "gzd";
            find = "gzf";
            find_left = "gzF";
            highlight = "gzh";
            replace = "gzr";
            update_n_lines = "gzn";
          };
        };
        icons = { };
        statusline = { };
        starter = { };
        # clue = {
        #   triggers = [
        #     # leader triggers
        #     {
        #       mode = "n";
        #       keys = "<leader>";
        #     }
        #     {
        #       mode = "x";
        #       keys = "<leader>";
        #     }
        #     # # built-in completion
        #     {
        #       mode = "i";
        #       keys = "<C-x>";
        #     }
        #     # # `g` key
        #     {
        #       mode = "n";
        #       keys = "g";
        #     }
        #     {
        #       mode = "x";
        #       keys = "g";
        #     }
        #     # # marks
        #     {
        #       mode = "n";
        #       keys = "\"";
        #     }
        #     {
        #       mode = "n";
        #       keys = "`";
        #     }
        #     {
        #       mode = "x";
        #       keys = "\"";
        #     }
        #     {
        #       mode = "x";
        #       keys = "`";
        #     }
        #     # # registers
        #     {
        #       mode = "n";
        #       keys = "\"";
        #     }
        #     {
        #       mode = "x";
        #       keys = "\"";
        #     }
        #     {
        #       mode = "i";
        #       keys = "<C-r>";
        #     }
        #     {
        #       mode = "c";
        #       keys = "<C-r>";
        #     }
        #     # # window commands
        #     {
        #       mode = "n";
        #       keys = "<C-w>";
        #     }
        #     # # `z` key
        #     {
        #       mode = "n";
        #       keys = "z";
        #     }
        #     {
        #       mode = "x";
        #       keys = "z";
        #     }
        #     ## bracketed
        #     {
        #       mode = "n";
        #       keys = "[";
        #     }
        #     {
        #       mode = "n";
        #       keys = "]";
        #     }
        #     {
        #       mode = "x";
        #       keys = "[";
        #     }
        #     {
        #       mode = "x";
        #       keys = "]";
        #     }
        #   ];
        #
        #   clues = [
        #     # Enhance this by adding descriptions for <leader> mapping groups
        #     { __raw = "require('mini.clue').gen_clues.builtin_completion()"; }
        #     { __raw = "require('mini.clue').gen_clues.g()"; }
        #     { __raw = "require('mini.clue').gen_clues.marks()"; }
        #     { __raw = "require('mini.clue').gen_clues.registers()"; }
        #     { __raw = "require('mini.clue').gen_clues.windows()"; }
        #     { __raw = "require('mini.clue').gen_clues.z()"; }
        #   ];
        #
        #   window = {
        #     config = {
        #       border = "single";
        #       width = "auto";
        #     };
        #     delay = 0;
        #   };
        # };
      };
      mini.mockDevIcons = true;
      fidget.enable = true;
      fzf-lua.enable = true;
      fzf-lua = {
        keymaps = {
          "<leader>sg" = "live_grep";
          "<leader>sf" = "files";
          "<leader>sr" = "resume";
          "<leader>s." = "oldfiles";
          "<leader>sw" = "grep_cword";
          "<leader>ss" = "builtin";
          "<leader>sk" = "keymaps";
          "<leader>sh" = "helptags";
          "<leader><leader>s" = "buffers";
          # "<C-p>" = {
          #   action = "git_files";
          #   settings = {
          #     previewers.cat.cmd = lib.getExe' pkgs.coreutils "cat";
          #     winopts.height = 0.5;
          #   };
          #   options = {
          #     silent = true;
          #     desc = "Fzf-Lua Git Files";
          #   };
          # };
        };

        profile = "fzf-native";
      };
      # harpoon.enable = true;
      oil = {
        enable = true;
        settings = {
          use_default_keymaps = true;
        };
      };

      telescope = {
        enable = false;
        keymaps = {
          "<leader>f" = "find_files";
          "<leader>b" = "buffers";
          "<leader>w" = "live_grep";
        };
      };

      dashboard = {
        enable = false;
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
                action = "FzfLua resume";
                desc = "Resume";
                icon = "󱪞 ";
                key = "r";
                key_format = "%s";
              }
              {
                action = "FzfLua oldfiles";
                desc = "Recently Opened Files";
                icon = "󱪞 ";
                key = ".";
                key_format = "%s";
              }
              {
                action = "FzfLua files";
                desc = "Find Files           ";
                icon = " ";
                key = "f";
                key_format = "%s";
              }
              {
                action = "FzfLua live_grep";
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

      -- [[ Setting options ]]
      -- See `:help vim.o`
      -- NOTE: You can change these options as you wish!

      -- Sets how neovim will display certain whitespace characters in the editor.
      --  See `:help 'list'`
      --  and `:help 'listchars'`
      vim.opt.list = true
      vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

      -- Set highlight on search
      vim.opt.hlsearch = true
      vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

      -- Preview substitutions live, as you type!
      vim.opt.inccommand = 'split'

      -- Minimal number of screen lines to keep above and below the cursor.
      vim.opt.scrolloff = 10

      -- Make line numbers default
      vim.wo.number = true

      -- Enable mouse mode
      vim.o.mouse = 'a'

      vim.o.filetype = "on"
      vim.o.showmode = false

      vim.o.swapfile = false

      -- Indent
      -- vim.o.smarttab = true
      vim.opt.cpoptions:append('I')
      vim.o.expandtab = true
      vim.o.smartindent = true
      vim.o.autoindent = true
      vim.o.tabstop = 4
      vim.o.softtabstop = 4
      vim.o.shiftwidth = 4

      -- stops line wrapping from being confusing
      vim.o.breakindent = true

      -- Save undo history
      vim.o.undofile = true

      -- Case-insensitive searching UNLESS \C or capital in search
      vim.o.ignorecase = true
      vim.o.smartcase = true

      -- Keep signcolumn on by default
      vim.wo.signcolumn = 'yes'
      vim.wo.relativenumber = true

      -- Decrease update time
      vim.o.updatetime = 250
      vim.o.timeoutlen = 300

      -- Set completeopt to have a better completion experience
      vim.o.completeopt = 'menu,preview,noselect'

      -- NOTE: You should make sure your terminal supports this
      vim.o.termguicolors = true

      vim.o.cursorline = true
      vim.o.cursorlineopt = 'both'

      vim.o.conceallevel = 1

      -- [[ Disable auto comment on enter ]]
      -- See :help formatoptions
      vim.api.nvim_create_autocmd("FileType", {
          desc = "remove formatoptions",
          callback = function()
              vim.opt.formatoptions:remove({ "c", "r", "o" })
          end,
      })

      -- [[ Highlight on yank ]]
      -- See `:help vim.highlight.on_yank()`
      local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
      vim.api.nvim_create_autocmd('TextYankPost', {
          callback = function()
              vim.highlight.on_yank()
          end,
          group = highlight_group,
          pattern = '*',
      })

      vim.g.netrw_liststyle = 0
      vim.g.netrw_banner = 0

      -- [[ Basic Keymaps ]]

      -- Diagnostic keymaps
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
    '';
  };
}
