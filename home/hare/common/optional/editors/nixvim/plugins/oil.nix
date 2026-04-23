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
          {
            __unkeyed = "permissions";
            highlight.__raw = ''
              function(permission_str)
                local hls = {}
                for i = 1, #permission_str do
                    local char = permission_str:sub(i, i)
                    table.insert(hls, {
                        ({
                            ['-'] = 'NonText',
                            ['r'] = 'DiagnosticSignWarn',
                            ['w'] = 'DiagnosticSignError',
                            ['x'] = 'DiagnosticSignOk',
                        })[char],
                        i - 1,
                        i
                    })
                end
                return hls
              end
            '';
          }
          "size"
          "mtime"
          "icon"
        ];
      };
    };

    oil-git-status.enable = true;
  };
}
