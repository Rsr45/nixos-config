{ ... }:
{
  programs.nixvim.keymaps = [
    {
      key = "<leader>te";
      mode = "n";
      action = "<cmd>Oil<CR>";
      options = {
        noremap = true;
        desc = "Oil Cwd";
      };
    }
    {
      key = "<leader>tE";
      mode = "n";
      action = "<cmd>Oil<CR>";
      options = {
        noremap = true;
        desc = "Oil Root";
      };
    }
    # {
    #   key = "<leader>o/";
    #   mode = "n";
    #   action = "<cmd>Oil<CR>";
    #   options = {
    #     noremap = true;
    #     desc = "Oil Cwd";
    #   };
    # }
  ];
  programs.nixvim.plugins = {
    oil = {
      enable = true;
      settings = {
        use_default_keymaps = true;
        win_options = {
          signcolumn = "yes:2";
        };
        view_options = {
          show_hidden = true;
        };
        columns = [
          "permissions"
          "size"
          "mtime"
          "icon"
        ];
      };
    };

    oil-git-status.enable = true;
  };
}
