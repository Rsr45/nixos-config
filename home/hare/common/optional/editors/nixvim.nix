{
  pkgs,
  inputs,
config,
  ...
}:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    # viAlias = true;
    # vimAlias = true;
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
      dracula-nvim
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

      treesitter = {
        enable = true;
        nixvimInjections = true;
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "buffer"; }
            { name = "luasnip"; }
            { name = "nvim_lsp"; }
            { name = "nvim_lua"; }
            { name = "path"; }
            { name = "treesitter"; }
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
            -- vim.opt.background = "dark"
            -- vim.cmd.colorscheme 'miasma'
            -- vim.cmd "let g:gruvbox_material_background = 'hard'"
            -- vim.cmd "let g:gruvbox_material_foreground = 'original'"
            -- NOTE: These 2 need to be set up before any plugins are loaded.
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

      -- Keymaps for better default experience
      -- See `:help vim.keymap.set()`
      vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Moves Line Down' })
      vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Moves Line Up' })
      vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = 'Scroll Down' })
      vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = 'Scroll Up' })
      vim.keymap.set("n", "n", "nzzzv", { desc = 'Next Search Result' })
      vim.keymap.set("n", "N", "Nzzzv", { desc = 'Previous Search Result' })

      vim.keymap.set("n", "<leader><leader>[", "<cmd>bprev<CR>", { desc = 'Previous buffer' })
      vim.keymap.set("n", "<leader><leader>]", "<cmd>bnext<CR>", { desc = 'Next buffer' })
      vim.keymap.set("n", "<leader><leader>l", "<cmd>b#<CR>", { desc = 'Last buffer' })
      vim.keymap.set("n", "<leader><leader>d", "<cmd>bdelete<CR>", { desc = 'delete buffer' })

      -- see help sticky keys on windows
      -- vim.cmd([[command! W w]])
      -- vim.cmd([[command! Wq wq]])
      -- vim.cmd([[command! WQ wq]])
      -- vim.cmd([[command! Q q]])

      -- Remap for dealing with word wrap
      vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
      vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

      -- Diagnostic keymaps
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })


      -- kickstart.nvim starts you with this.
      -- But it constantly clobbers your system clipboard whenever you delete anything.

      -- Sync clipboard between OS and Neovim.
      --  Remove this option if you want your OS clipboard to remain independent.
      --  See `:help 'clipboard'`
      -- vim.o.clipboard = 'unnamedplus'

      -- You should instead use these keybindings so that they are still easy to use, but dont conflict
      vim.keymap.set({ "v", "x", "n" }, '<leader>y', '"+y', { noremap = true, silent = true, desc = 'Yank to clipboard' })
      vim.keymap.set({ "n", "v", "x" }, '<leader>Y', '"+yy', { noremap = true, silent = true, desc = 'Yank line to clipboard' })
      vim.keymap.set({ "n", "v", "x" }, '<C-a>', 'gg0vG$', { noremap = true, silent = true, desc = 'Select all' })
      vim.keymap.set({ 'n', 'v', 'x' }, '<leader>p', '"+p', { noremap = true, silent = true, desc = 'Paste from clipboard' })
      vim.keymap.set('i', '<C-p>', '<C-r><C-p>+',
          { noremap = true, silent = true, desc = 'Paste from clipboard from within insert mode' })
      vim.keymap.set("x", "<leader>P", '"_dP',
          { noremap = true, silent = true, desc = 'Paste over selection without erasing unnamed register' })
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
