{ ... }:
{
  programs.nixvim = {
    plugins.mini-pick = {
      enable = true;
    };

    keymaps = [
      {
        key = "<leader><leader>";
        mode = [ "n" ];
        action = "<cmd>Pick files<CR>";
        options.desc = "Files";
      }
      {
        key = "<leader>,";
        mode = [ "n" ];
        action = "<cmd>Pick buffers<CR>";
        options.desc = "Buffers";
      }
      {
        key = "<leader>.";
        mode = [ "n" ];
        action = "<cmd>Pick options<CR>";
        options.desc = "Options";
      }
      {
        key = "<leader>/";
        mode = [ "n" ];
        action = "<cmd>Pick grep_live<CR>";
        options.desc = "Grep";
      }
      {
        key = "<leader>'";
        mode = [ "n" ];
        action = "<cmd>Pick registers<CR>";
        options.desc = "Registers";
      }
      {
        key = "<leader>:";
        mode = [ "n" ];
        action = "<cmd>Pick commands<CR>";
        options.desc = "Commands";
      }
      {
        key = "<leader>d";
        mode = [ "n" ];
        action = "<cmd>Pick diagnostic<CR>";
        options.desc = "Diagnostic";
      }
      {
        key = "z=";
        mode = [ "n" ];
        action = "<cmd>Pick spellsuggest<CR>";
        options.desc = "Show spelling suggestions";
      }
      {
        key = "<leader>ss";
        mode = [ "n" ];
        action = "<cmd>Pick buf_lines<CR>";
        options.desc = "Grep lines";
      }
      {
        key = "<leader>fr";
        mode = [ "n" ];
        action = "<cmd>Pick oldfiles<CR>";
        options.desc = "Oldfiles";
      }
    ];
  };

  # programs.nixvim = {
  #   plugins.snacks = {
  #     enable = true;
  #     settings = {
  #       picker = {
  #         sources = {
  #           buffers = {
  #             current = false;
  #           };
  #           explorer = {
  #             tree = false;
  #             # layout = {
  #             #   preset = "vertico";
  #             # };
  #             auto_close = true;
  #           };
  #         };
  #
  #         prompt = "> ";
  #         # layout = "";
  #         layouts = {
  #           vertico = {
  #             layout = {
  #               box = "vertical";
  #               backdrop = false;
  #               row = -1;
  #               width = 0;
  #               height = 0.3;
  #               title = "{title} {live} {flags}";
  #               title_pos = "left";
  #               border = "top";
  #
  #               children = [
  #                 {
  #                   win = "input";
  #                   height = 1;
  #                 }
  #                 {
  #                   win = "list";
  #                   border = "none";
  #                 }
  #                 {
  #                   win = "preview";
  #                   title = "{preview}";
  #                   width = 0.6;
  #                   border = "left";
  #                 }
  #               ];
  #             };
  #           };
  #         };
  #       };
  #     };
  #   };
  #
  #   keymaps = [
  #     {
  #       key = "<leader>ff";
  #       mode = [ "n" ];
  #       action = "<cmd>lua Snacks.picker.files()<CR>";
  #       options.desc = "Files";
  #     }
  #     {
  #       key = "<leader>fF";
  #       mode = [ "n" ];
  #       action.__raw = "function() Snacks.picker.files({ cwd = require('oil').get_current_dir() }) end";
  #       options = {
  #         desc = "Files cwd";
  #         nowait = true;
  #       };
  #     }
  #     {
  #       key = "<leader>fr";
  #       mode = [ "n" ];
  #       action.__raw = "function() Snacks.picker.recent() end";
  #       options.desc = "Recent";
  #     }
  #     # {
  #     #   key = "<leader>fd";
  #     #   mode = [ "n" ];
  #     #   action.__raw = "function() Snacks.picker.diagnostics() end";
  #     #   options.desc = "Diagnostics";
  #     # }
  #     {
  #       key = "<leader>fD";
  #       mode = [ "n" ];
  #       action.__raw = "function() Snacks.picker.diagnostics_buffer() end";
  #       options.desc = "Diagnostics Buffer";
  #     }
  #     # {
  #     #   key = "<leader>fF";
  #     #   mode = [ "n" ];
  #     #   action = "function() Snacks.picker.files({ cwd = require('oil').get_current_dir() }) end";
  #     #   options.desc = "Files cwd";
  #     # }
  #     # {
  #     #   key = "<leader>fF";
  #     #   mode = [ "n" ];
  #     #   action = "function() Snacks.picker.files({ cwd = require('oil').get_current_dir() }) end";
  #     #   options.desc = "Files cwd";
  #     # }
  #     {
  #       key = "<leader>fe";
  #       mode = [ "n" ];
  #       action.__raw = "function() Snacks.picker.explorer({ cwd = require('oil').get_current_dir() }) end";
  #       options = {
  #         desc = "Explorer";
  #         nowait = true;
  #       };
  #     }
  #     {
  #       key = "<leader>sg";
  #       mode = [ "n" ];
  #       action.__raw = "function() Snacks.picker.grep() end";
  #       options.desc = "Grep";
  #     }
  #     {
  #       key = "<leader>sw";
  #       mode = [ "n" ];
  #       action.__raw = "function() Snacks.picker.grep_word() end";
  #       options.desc = "Grep Word";
  #     }
  #     {
  #       key = "<leader>sb";
  #       mode = [ "n" ];
  #       action.__raw = "function() Snacks.picker.lines() end";
  #       options.desc = "Lines";
  #     }
  #     {
  #       key = "<leader>ss";
  #       mode = [ "n" ];
  #       action.__raw = "function() Snacks.picker.lines() end";
  #       options.desc = "Grep current buffer";
  #     }
  #     {
  #       key = "<leader>te";
  #       mode = [ "n" ];
  #       action.__raw = "function() Snacks.picker.explorer({ cwd = require('oil').get_current_dir() }) end";
  #       options = {
  #         desc = "Explorer";
  #         nowait = true;
  #       };
  #     }
  #     # {
  #     #   key = "<leader><leader>";
  #     #   mode = [ "n" ];
  #     #   action = "<cmd>lua Snacks.picker.files()<CR>";
  #     #   options.desc = "Files";
  #     # }
  #     # {
  #     #   key = "<leader>,";
  #     #   mode = [ "n" ];
  #     #   action.__raw = "function() Snacks.picker.buffers() end";
  #     #   options.desc = "Buffers";
  #     # }
  #     # {
  #     #   key = "<leader>.";
  #     #   mode = [ "n" ];
  #     #   action.__raw = "function() Snacks.picker.files({ cwd = require('oil').get_current_dir() }) end";
  #     #   options = {
  #     #     desc = "Files cwd";
  #     #     nowait = true;
  #     #   };
  #     # }
  #     # {
  #     #   key = "<leader>/";
  #     #   mode = [ "n" ];
  #     #   action.__raw = "function() Snacks.picker.grep() end";
  #     #   options.desc = "Grep";
  #     # }
  #     {
  #       key = "<leader>:";
  #       mode = [ "n" ];
  #       action.__raw = "function() Snacks.picker.command_history() end";
  #       options.desc = "Command History";
  #     }
  #     {
  #       key = "<leader>U";
  #       mode = [ "n" ];
  #       action.__raw = "function() Snacks.picker.undo() end";
  #       options.desc = "Undo";
  #     }
  #   ];
  # };
}
