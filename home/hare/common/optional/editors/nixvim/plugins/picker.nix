{ ... }:
{
  programs.nixvim.keymaps = [
    {
      key = "<leader>ff";
      mode = [ "n" ];
      action = "<cmd>lua Snacks.picker.files()<CR>";
      options.desc = "Files";
    }
    {
      key = "<leader>fF";
      mode = [ "n" ];
      action = "function() Snacks.picker.files({ cwd = require('oil').get_current_dir() }) end";
      options.desc = "Files cwd";
    }
    {
      key = "<leader>fr";
      mode = [ "n" ];
      action = "function() Snacks.picker.recent() end";
      options.desc = "Recent";
    }
    {
      key = "<leader>fd";
      mode = [ "n" ];
      action = "function() Snacks.picker.diagnostics() end";
      options.desc = "Diagnostics";
    }
    # {
    #   key = "<leader>fF";
    #   mode = [ "n" ];
    #   action = "function() Snacks.picker.files({ cwd = require('oil').get_current_dir() }) end";
    #   options.desc = "Files cwd";
    # }
    # {
    #   key = "<leader>fF";
    #   mode = [ "n" ];
    #   action = "function() Snacks.picker.files({ cwd = require('oil').get_current_dir() }) end";
    #   options.desc = "Files cwd";
    # }
    {
      key = "<leader>te";
      mode = [ "n" ];
      action = "function() Snacks.picker.explorer({ cwd = require('oil').get_current_dir() }) end";
      options.desc = "Explorer";
    }
    {
      key = "<leader>,";
      mode = [ "n" ];
      action = "function() Snacks.picker.buffers() end";
      options.desc = "Buffers";
    }
    {
      key = "<leader>.";
      mode = [ "n" ];
      action = "function() Snacks.picker.files({ cwd = require('oil').get_current_dir() }) end";
      options.desc = "Files cwd";
    }
    {
      key = "<leader>/";
      mode = [ "n" ];
      action = "function() Snacks.picker.grep() end";
      options.desc = "Grep";
    }
    {
      key = "<leader>:";
      mode = [ "n" ];
      action = "function() Snacks.picker.command_history() end";
      options.desc = "Command History";
    }
    {
      key = "<leader><leader>";
      mode = [ "n" ];
      action = "<cmd>lua Snacks.picker.files()<CR>";
      options.desc = "Files";
    }
    {
      key = "<leader>U";
      mode = [ "n" ];
      action = "function() Snacks.picker.undo() end";
      options.desc = "Undo";
    }
  ];
  programs.nixvim.plugins = {
    snacks = {
      enable = true;
      settings = {
        picker = { };
      };
    };
  };
}
