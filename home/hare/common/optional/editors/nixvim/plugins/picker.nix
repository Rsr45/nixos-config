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
      # {
      #   key = "<leader>.";
      #   mode = [ "n" ];
      #   action = "<cmd>Pick options<CR>";
      #   options.desc = "Options";
      # }
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
    ];
  };
}
