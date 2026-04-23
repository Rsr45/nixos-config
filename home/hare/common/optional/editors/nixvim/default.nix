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
      # === Indent ===
      # vim.opt.cpoptions:append('I')
      # expandtab = true;
      # smarttab = true;
      # smartindent = true;
      # autoindent = true;
      # tabstop = 4;
      # softtabstop = 4;
      # shiftwidth = 4;
      showmode = false;
      number = true;
      relativenumber = true;
      cursorline = true;
      background = "dark";
      breakindent = true;
      wrap = true;
      inccommand = "split";
      spell = false;
      shell = "bash";
      winborder = "bold";
      laststatus = 3;
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

      trouble.enable = true;

      # intellitab.enable = true;

      nix.enable = true;
      lspconfig.enable = true;

      guess-indent.enable = true;

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
          completion = {
            menu = {
              border = "bold";
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

      smartcolumn.enable = false;
      flash.enable = true;
      flash.settings = {
        modes.char.jump_labels = true;
      };

      # Multi Cursor
      # visual-multi.enable = false;
      multicursors.enable = true;
      image.enable = true;

      # fidget.enable = false;
      # fzf-lua = {
      #   enable = false;
      #   keymaps = {
      #     "<leader>sg" = "live_grep";
      #     "<leader>sf" = "files";
      #     "<leader>sr" = "resume";
      #     "<leader>s." = "oldfiles";
      #     "<leader>sw" = "grep_cword";
      #     "<leader>ss" = "builtin";
      #     "<leader>sk" = "keymaps";
      #     "<leader>hs" = "helptags";
      #     "<leader>sb" = "buffers";
      #     "<leader><leader>" = {
      #       action = "files";
      #       # settings = {
      #       #   previewers.cat.cmd = lib.getExe' pkgs.coreutils "cat";
      #       #   winopts.height = 0.5;
      #       # };
      #       options = {
      #         # silent = true;
      #         desc = "Files";
      #       };
      #     };
      #   };
      #
      #   profile = "fzf-native";
      # };
      # harpoon.enable = true;

      # project-nvim.enable = true;
    };
    # extraConfigLuaPre = ''
    #   -- Sets how neovim will display certain whitespace characters in the editor.
    #   --  See `:help 'list'`
    #   --  and `:help 'listchars'`
    #   vim.opt.list = true
    #   vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
    #
    #   -- Set highlight on search
    #   vim.opt.hlsearch = true
    #   vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
    #
    #   -- Minimal number of screen lines to keep above and below the cursor.
    #   vim.opt.scrolloff = 10
    #
    #   -- Enable mouse mode
    #   vim.o.mouse = 'a'
    #
    #   vim.o.filetype = "on"
    #   vim.o.showmode = false
    #
    #   vim.o.swapfile = false
    #
    #
    #
    #
    #
    #   -- Save undo history
    #   vim.o.undofile = true
    #
    #   -- Case-insensitive searching UNLESS \C or capital in search
    #   vim.o.ignorecase = true
    #   vim.o.smartcase = true
    #
    #   -- Keep signcolumn on by default
    #   vim.wo.signcolumn = 'yes'
    #   vim.wo.relativenumber = true
    #
    #   -- Decrease update time
    #   vim.o.updatetime = 250
    #   vim.o.timeoutlen = 300
    #
    #   -- Set completeopt to have a better completion experience
    #   vim.o.completeopt = 'menu,preview,noselect'
    #
    #   -- NOTE: You should make sure your terminal supports this
    #   vim.o.termguicolors = true
    #
    #   vim.o.cursorline = true
    #   vim.o.cursorlineopt = 'both'
    #
    #   vim.o.conceallevel = 1
    #
    #   -- [[ Disable auto comment on enter ]]
    #   -- See :help formatoptions
    #   vim.api.nvim_create_autocmd("FileType", {
    #       desc = "remove formatoptions",
    #       callback = function()
    #           vim.opt.formatoptions:remove({ "c", "r", "o" })
    #       end,
    #   })
    #
    #   -- [[ Highlight on yank ]]
    #   -- See `:help vim.highlight.on_yank()`
    #   local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
    #   vim.api.nvim_create_autocmd('TextYankPost', {
    #       callback = function()
    #           vim.highlight.on_yank()
    #       end,
    #       group = highlight_group,
    #       pattern = '*',
    #   })
    # '';
  };
}
