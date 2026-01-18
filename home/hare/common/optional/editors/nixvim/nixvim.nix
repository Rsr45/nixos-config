{
  pkgs,
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

    globals = {
      mapleader = " ";
      maplocalleader = " ";
      netrw_liststyle = 0;
      netrw_banner = 0;
    };

    colorscheme = "pywal";
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
        enable = true;
        settings = { };
      };

      trouble.enable = true;

      intellitab.enable = true;

      dropbar.enable = false;
      neorg.enable = true;

      neogit.enable = true;

      obsidian.enable = true;
      obsidian = {
        settings = {
          ui.enable = true;
          frontmatter = {
            enabled = true;
            func = ''
              function(note)
                -- Add the title of the note as an alias.
                if note.title then
                  note:add_alias(note.title)
                end

                local out = { id = note.id, aliases = note.aliases, tags = note.tags }

                -- `note.metadata` contains any manually added fields in the frontmatter.
                -- So here we just make sure those fields are kept in the frontmatter.
                if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
                  for k, v in pairs(note.metadata) do
                    out[k] = v
                  end
                end

                return out
              end
            '';
          };
          legacy_commands = false;
          workspaces = [
            {
              name = "Personal";
              path = "~/Personal/Vaults/Personal";
              overrides = {
                notes_subdir = "05_Fleeting";
                attachments = {
                  img_folder = "99_Meta/01_Assets/imgs";
                };
              };
            }
            {
              name = "Work";
              path = "~/Personal/Vaults/Dev";
              # overrides = {
              #   notes_subdir = "05_Fleeting";
              #   attachments = {
              #     img_folder = "99_Meta/01_Assets/imgs";
              #   };
              # };
            }
          ];

          templates = {
            folder = "99_Meta/00_Templates";
            date_format = "%Y-%m-%d";
            time_format = "%H:%M";
            # substitutions = {};
            # customizations = {};
          };

          note_id_func = ''
            function(title)
              -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
              -- In this case a note with the title 'My new note' will be given an ID that looks
              -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
              local suffix = ""
              if title ~= nil then
                -- If title is given, transform it into valid file name.
                suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
              else
                -- If title is nil, just add 4 random uppercase letters to the suffix.
                for _ = 1, 4 do
                  suffix = suffix .. string.char(math.random(65, 90))
                end
              end
              return tostring(os.time()) .. "-" .. suffix
            end
          '';
        };
      };

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
      };

      highlight-colors.enable = true;
      highlight-colors.settings = {
        render = "virtual";
        virtual_symbol = "■";
        virtual_symbol_position = "inline";
      };

      diffview.enable = true;

      snacks.enable = true;
      snacks.settings = {
        statuscolumn = {
          enabled = false;
          left = [
            "mark"
            "sign"
            "fold"
            "git"
          ];
          right = [
          ];
        };
        indent.enabled = true;
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
        zen = {
          enabled = true;
        };
        picker = {
          layout = {
            preview = "ivy";
          };
          preset = "ivy";
        };
      };

      smartcolumn.enable = true;
      flash.enable = true;
      flash.settings = {
        modes.char.jump_labels = true;
      };
      visual-multi.enable = false;

      lualine.enable = false;

      fidget.enable = true;
      fzf-lua.enable = false;
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
