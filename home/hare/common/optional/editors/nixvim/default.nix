{
  inputs,
  ...
}:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./keymaps.nix
    ./languages.nix
    ./plugins.nix
  ];

  programs.nixvim = {
    enable = true;
    viAlias = false;
    vimAlias = false;
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

    globals = {
      mapleader = " ";
      maplocalleader = " ";
      netrw_liststyle = 0;
      netrw_banner = 0;
    };

    colorscheme = "neopywal";
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
        dark = "wave";
        light = "lotus";
      };
      transparent = true;
      undercurl = true;
    };

    diagnostic.settings = {
      virtual_lines = false;
      virtual_text = false;
      underline = true;
      signs = true;
    };

    clipboard.providers = {
      wl-copy.enable = true;
      xclip.enable = true;
    };

    plugins = {
      conform-nvim.enable = true;

      noice = {
        enable = false;
        settings = { };
      };

      trouble.enable = true;

      intellitab.enable = true;

      dropbar.enable = false;

      neogit.enable = true;
      fugitive.enable = true;
      gitsigns.enable = true;
      nix.enable = true;
      lspconfig.enable = true;
      lsp-format = {
        enable = true;
      };

      # navic = {
      #   enable = true;
      #   luaConfig.post = "vim.o.winbar = \"%{%v:lua.require'nvim-navic'.get_location()%}\"";
      #   settings = {
      #     highlight = true;
      #     lsp = {
      #       auto_attach = true;
      #     };
      #   };
      # };

      treesitter = {
        enable = true;
        nixvimInjections = true;
      };

      blink-cmp = {
        enable = true;
        settings = {
          cmdline = {
            keymap = {
              preset = "inherit";
            };
            completion = {
              menu = {
                auto_show = true;
              };
            };
          };
        };
      };

      highlight-colors.enable = true;
      highlight-colors.settings = {
        render = "virtual";
        virtual_symbol = "■";
        virtual_symbol_position = "inline";
      };

      diffview.enable = true;

      smartcolumn.enable = true;
      flash.enable = true;
      flash.settings = {
        modes.char.jump_labels = true;
      };
      visual-multi.enable = false;

      fidget.enable = true;
      fzf-lua = {
        enable = false;
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

      project-nvim.enable = true;
    };
    extraConfigLuaPre = ''
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
    '';
  };
}
