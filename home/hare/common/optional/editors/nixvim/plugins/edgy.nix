{ ... }:
{
  programs.nixvim.plugins.edgy = {
    enable = true;
    settings = {
      animate = {
        enabled = false;
      };
      bottom = [
        {
          ft = "trouble";
          title = "Trouble";
          filter = ''
            function(buf, win)
              local props = vim.api.nvim_win_get_config(win)
              return props.split == "below"
            end
          '';
        }
        {
          filter = ''
            function(buf, win)
              return vim.api.nvim_win_get_config(win).relative == ""
            end
          '';
          ft = "snacks_terminal";
          size = 30;
        }
        {
          filter = ''
            function(buf, win)
              return vim.api.nvim_win_get_config(win).relative == ""
            end
          '';
          ft = "toggleterm";
          size = 30;
        }
        {
          ft = "diff";
          size = 20;
          filter = ''
            function(buf, win)
              return vim.api.nvim_win_get_config(win).relative == ""
              end
          '';
        }
        {
          ft = "lazyterm";
          title = "LazyTerm";
          size = 40;
          filter = ''
            function(buf)
              return not vim.b[buf].lazyterm_cmd
              end
          '';
        }
        {
          filter = ''
            function(buf)
              return vim.bo[buf].buftype == "help"
            end
          '';
          ft = "help";
          size = 20;
        }
        {
          ft = "qf";
          title = "QuickFix";
        }
        {
          ft = "spectre_panel";
        }
      ];
      left = [
        {
          ft = "NvimTree";
          size = 30;
          title = "nvimtree";
        }
        {
          ft = "Outline";
          open = "SymbolsOutline";
        }
        {
          ft = "dapui_scopes";
        }
        {
          ft = "dapui_breakpoints";
        }
        {
          ft = "dap-repl";
        }
      ];
      right = [
        {
          ft = "trouble";
          title = "Trouble";
          filter = ''
            function(buf, win)
                local props = vim.api.nvim_win_get_config(win)
                return props.split == "right"
            end
          '';
        }
      ];
      wo = {
        signcolumn = "no";
        spell = false;
        winbar = false;
        winfixheight = false;
        winfixwidth = false;
        winhighlight = "";
      };
    };
  };
}
