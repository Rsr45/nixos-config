{ ... }:

{
  programs.nixvim.keymaps = [
    # {
    #   key = "<leader>te";
    #   mode = [ "n" ];
    #   action = "<cmd>lua Snacks.explorer.open({ layout = { preset = \"default\" }})<CR>";
    #   options.desc = "Explorer";
    # }
    {
      key = "<leader>tp";
      mode = [ "n" ];
      action = "<cmd>lua Snacks.explorer.open({ layout = { preset = \"left\" }})<CR>";
      options.desc = "Sidebar";
    }
    {
      key = "<leader>tt";
      mode = [ "n" ];
      action = "<cmd>lua Snacks.terminal.toggle()<CR>";
      options.desc = "toggle terminal";
    }
    {
      key = "<leader>tT";
      mode = [ "n" ];
      action = "<cmd>terminal<CR>";
      options.desc = "open Terminal";
    }
  ];
  programs.nixvim.plugins.snacks = {
    enable = true;
    settings = {
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
      indent.enabled = false;
      words = {
        enabled = false;
      };
      scope = {
        enabled = true;
      };
      notifier = {
        enabled = false;
      };
      image = {
        enabled = true;
      };
      zen = {
        enabled = true;
      };
      bigfile = {
        enabled = true;
      };
      quickfile = {
        enabled = true;
      };
      input = {
        enabled = true;
      };
      explorer = {
        enabled = true;
      };
    };
  };
}
