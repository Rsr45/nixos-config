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
        key = "<leader>/";
        mode = [ "n" ];
        action = "<cmd>Pick grep_live<CR>";
        options.desc = "Grep";
      }
    ];
  };
}
