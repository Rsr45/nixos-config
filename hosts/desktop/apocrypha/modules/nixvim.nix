{pkgs, ...}: {
  programs.nixvim = {
    enable = true;
    clipboard.providers = {
      wl-copy.enable = true;
      xclip.enable = true;
    };
    colorschemes = {
      gruvbox = {
        enable = true;
        settings = {
          contrast = "hard"; # can be "hard", "soft" or empty string
        };
      };
      oxocarbon.enable = false;
    };
    extraPlugins = with pkgs.vimPlugins; [
      miasma-nvim
      gruvbox-material
    ];
    plugins = {
      web-devicons.enable = true;
      lualine = {
        enable = true;
        # settings = {
        #   options = {
        #     disabled_filetypes = {
        #       __unkeyed-1 = "startify";
        #       __unkeyed-2 = "neo-tree";
        #       statusline = [
        #         "dap-repl"
        #       ];
        #       winbar = [
        #         "aerial"
        #         "dap-repl"
        #         "neotest-summary"
        #       ];
        #     };
        #     globalstatus = true;
        #   };
        #   sections = {
        #     lualine_a = [
        #       "mode"
        #     ];
        #     lualine_b = [
        #       "branch"
        #     ];
        #     lualine_c = [
        #       "filename"
        #       "diff"
        #     ];
        #     lualine_x = [
        #       "diagnostics"
        #       {
        #         __unkeyed-1 = {
        #           __raw = ''
        #             function()
        #                 local msg = ""
        #                 local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        #                 local clients = vim.lsp.get_active_clients()
        #                 if next(clients) == nil then
        #                     return msg
        #                 end
        #                 for _, client in ipairs(clients) do
        #                     local filetypes = client.config.filetypes
        #                     if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        #                         return client.name
        #                     end
        #                 end
        #                 return msg
        #             end
        #           '';
        #         };
        #         icon = "";
        #       }
        #       "encoding"
        #       "fileformat"
        #       "filetype"
        #     ];
        #     lualine_y = [
        #       {
        #         __unkeyed-1 = "aerial";
        #         colored = true;
        #         cond = {
        #           __raw = ''
        #             function()
        #               local buf_size_limit = 1024 * 1024
        #               if vim.api.nvim_buf_get_offset(0, vim.api.nvim_buf_line_count(0)) > buf_size_limit then
        #                 return false
        #               end

        #               return true
        #             end
        #           '';
        #         };
        #         dense = false;
        #         dense_sep = ".";
        #         depth = {
        #           __raw = "nil";
        #         };
        #         sep = " ) ";
        #       }
        #     ];
        #     lualine_z = [
        #       {
        #         __unkeyed-1 = "location";
        #       }
        #     ];
        #   };
        #   tabline = {
        #     lualine_a = [
        #       {
        #         __unkeyed-1 = "buffers";
        #         symbols = {
        #           alternate_file = "";
        #         };
        #       }
        #     ];
        #     lualine_z = [
        #       "tabs"
        #     ];
        #   };
        #   winbar = {
        #     lualine_c = [
        #       {
        #         __unkeyed-1 = "navic";
        #       }
        #     ];
        #     lualine_x = [
        #       {
        #         __unkeyed-1 = "filename";
        #         newfile_status = true;
        #         path = 3;
        #         shorting_target = 150;
        #       }
        #     ];
        #   };
        # };
      };
      notify = {
        enable = true;
      };
      nix.enable = true;
      numbertoggle.enable = true;
      nvim-tree = {
        enable = true;
      };
      which-key = {
        enable = true;
      };
      intellitab = {
        enable = true;
        # package = pkgs.vimPlugins.intellitab-nvim;
      };
      comment = {
        enable = true;
      };
      lsp = {
        enable = true;
        servers = {
          # # Nix
          nil_ls.enable = true;
          # nixd = {
          #   enable = true;
          #   settings = {
          #     nixpkgs = {
          #       expr = "import (builtins.getFlake \"/home/hare/nixos-config\").inputs.nixpkgs { }   ";
          #     };
          #     options = {
          #       nixos.expr = "(builtins.getFlake \"/home/hare/nixos-config\").nixosConfigurations.apocrypha.options";
          #       home-manager.expr = "(builtins.getFlake \"/home/hare/nixos-config\").homeConfigurations.apocrypha.options";
          #     };
          #   };
          # };
          # # Lua
          # lua_ls.enable = true;
          # # TypeScript
          ts_ls.enable = true;
        };
      };
      treesitter = {
        enable = true;
        nixvimInjections = true;
      };
      cmp-buffer.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-nvim-lua.enable = true;
      cmp-path.enable = true;
      cmp-treesitter.enable = true;
      cmp_luasnip.enable = true;
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
            expand = ''
              function(args)
              require('luasnip').lsp_expand(args.body)
              end
            '';
          };
        };
      };
      nvim-colorizer = {
        enable = true;
        userDefaultOptions = {
          mode = "background";
        };
      };
      telescope = {
        enable = true;
        extensions = {
          fzf-native = {
            enable = true;
          };
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
      vim.opt.background = "dark"
      -- vim.cmd.colorscheme 'gruvbox-material'
      -- vim.cmd "let g:gruvbox_material_background = 'hard'"
      -- vim.cmd "let g:gruvbox_material_foreground = 'original'"
    '';
    extraConfigLua = ''
      -- Make line numbers default1
      vim.opt.number = true
      vim.opt.relativenumber = true

      -- Enable mouse mode.
      vim.opt.mouse = 'a'

      -- Don't show the mode.
      vim.opt.showmode = false

      -- Enable break indent
      vim.opt.breakindent = true

      -- Save undo history
      vim.opt.undofile = true

      -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
      vim.opt.ignorecase = true
      vim.opt.smartcase = true

      -- Keep signcolumn on by default
      vim.opt.signcolumn = 'yes'

      -- Decrease update time
      vim.opt.updatetime = 250

      -- Decrease mapped sequence wait time
      -- Displays which-key popup sooner
      vim.opt.timeoutlen = 300

      -- Configure how new splits should be opened
      vim.opt.splitright = true
      vim.opt.splitbelow = true

      -- Sets how neovim will display certain whitespace characters in the editor.
      --  See `:help 'list'`
      --  and `:help 'listchars'`
      vim.opt.list = true
      vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

      -- Preview substitutions live, as you type!
      vim.opt.inccommand = 'split'

      -- Show which line your cursor is on
      vim.opt.cursorline = true

      -- Minimal number of screen lines to keep above and below the cursor.
      vim.opt.scrolloff = 10

      -- [[ Basic Keymaps ]]
      --  See `:help vim.keymap.set()`

      -- Clear highlights on search when pressing <Esc> in normal mode
      --  See `:help hlsearch`
      vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

      -- Diagnostic keymaps
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

      -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
      -- or just use <C-\><C-n> to exit terminal mode
      vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

      -- Keybinds to make split navigation easier.
      --  Use CTRL+<←↓↑→> to switch between windows
      --
      --  See `:help wincmd` for a list of all window commands
      vim.keymap.set('n', '<C-left>', '<C-w><C-left>', { desc = 'Move focus to the left window' })
      vim.keymap.set('n', '<C-right>', '<C-w><C-right>', { desc = 'Move focus to the right window' })
      vim.keymap.set('n', '<C-down>', '<C-w><C-down>', { desc = 'Move focus to the lower window' })
      vim.keymap.set('n', '<C-up>', '<C-w><C-up>', { desc = 'Move focus to the upper window' })
    '';
    extraConfigLuaPost = '''';
  };
}
