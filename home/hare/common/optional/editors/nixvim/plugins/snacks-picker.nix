{ ... }:

{
  programs.nixvim.keymaps = [
    {
      key = "<leader>ff";
      mode = [ "n" ];
      action = "<cmd>lua Snacks.picker.files()<CR>";
      options.desc = "Files";
    }
    # {
    #   key = "<leader>pp";
    #   mode = [ "n" ];
    #   action.__raw = "function() if vim.fs.find({ '.git', '_darcs', '.hg', '.bzr', '.svn', 'package.json', 'Makefile', }, { upward = true, path = vim.loop.cwd() })[1] then require('snacks').picker.files() else require('snacks').picker.projects() end end";
    #   options.desc = "Projects/Files";
    # }
    {
      key = "<leader><leader>";
      mode = [ "n" ];
      action.__raw = "function() if vim.fs.find({ '.git', '_darcs', '.hg', '.bzr', '.svn', 'package.json', 'Makefile', }, { upward = true, path = vim.loop.cwd() })[1] then require('snacks').picker.files() else require('snacks').picker.projects() end end";
      options.desc = "Projects/Files";
    }
    {
      key = "<leader>,";
      mode = [ "n" ];
      action = "<cmd>lua Snacks.picker.buffers()<CR>";
      options.desc = "Buffers";
    }
    # {
    #   key = "<leader>.";
    #   mode = [ "n" ];
    #   action = "<cmd>Pick options<CR>";
    #   options.desc = "Options";
    # }
    {
      key = "<leader>/";
      mode = [ "n" ];
      action = "<cmd>lua Snacks.picker.grep()<CR>";
      options.desc = "Grep";
    }
    # {
    #   key = "<leader>'";
    #   mode = [ "n" ];
    #   action = "<cmd>Pick registers<CR>";
    #   options.desc = "Registers";
    # }
    # {
    #   key = "<leader>:";
    #   mode = [ "n" ];
    #   action = "<cmd>Pick commands<CR>";
    #   options.desc = "Commands";
    # }
    # {
    #   key = "<leader>d";
    #   mode = [ "n" ];
    #   action = "<cmd>Pick diagnostic<CR>";
    #   options.desc = "Diagnostic";
    # }
    # {
    #   key = "z=";
    #   mode = [ "n" ];
    #   action = "<cmd>Pick spellsuggest<CR>";
    #   options.desc = "Show spelling suggestions";
    # }
    # {
    #   key = "<leader>ss";
    #   mode = [ "n" ];
    #   action = "<cmd>Pick buf_lines<CR>";
    #   options.desc = "Grep lines";
    # }
    # {
    #   key = "<leader>fr";
    #   mode = [ "n" ];
    #   action = "<cmd>Pick oldfiles<CR>";
    #   options.desc = "Oldfiles";
    # }
  ];
  programs.nixvim.plugins.snacks = {
    enable = true;
    settings = {
      picker = {
        en = 0;
        prompt = "> ";
        layout = "vertico";
        layouts = {
          vertico = {
            layout = {
              box = "vertical";
              backdrop = false;
              row = -1;
              width = 0;
              height = 0.3;

              title = " {title} {live} {flags}";
              title_pos = "left";
              border = "top";
              __unkeyed-1 = {
                height = 1;
                win = "input";
              };

              __unkeyed-2 = {
                box = "horizontal";

                __unkeyed-1 = {
                  win = "list";
                  border = "none";
                };

                __unkeyed-2 = {
                  win = "preview";
                  title = "{preview}";
                  width = 0.6;
                  border = "left";
                };
              };
            };
          };
          vertico_no_preview = {
            layout = {
              box = "vertical";
              backdrop = false;
              row = -1;
              width = 0;
              height = 0.3;
              title = " {title} {live} {flags}";
              title_pos = "left";
              border = "top";

              __unkeyed-1 = {
                height = 1;
                win = "input";
              };

              __unkeyed-2 = {
                box = "horizontal";

                __unkeyed-1 = {
                  win = "list";
                  border = "none";
                };
              };
            };
          };
        };

        sources = {
          explorer = {
            tree = false;
            layout = {
              preset = "vertico";
            };
            auto_close = true;
          };
          buffers = {
            current = false;
          };
          projects = {
            dev = [
              "~/Dev"
              "~/Projects"
            ];
            confirm = "load_session";
            patterns = [
              ".git"
              "_darcs"
              ".hg"
              ".bzr"
              ".svn"
              "package.json"
              "Makefile"
              ".editorconfig"
            ];
            recent = true;
            matcher = {
              frecency = true;
              sort_empty = true;
              cwd_bonus = true;
            };
            sort = {
              fields = [
                "score:desc"
                "idx"
              ];
            };
          };
        };
      };
    };
  };
}
