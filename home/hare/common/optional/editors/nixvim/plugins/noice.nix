{ ... }:
{
  programs.nixvim.plugins.noice = {
    enable = true;
    settings = {
      lsp = {
        override = {
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.stylize_markdown" = true;
        };
        signature = {
          enabled = true;
        };
        hover = {
          enabled = false;
        };
      };
      presets = {
        bottom_search = false;
        command_palette = true;
        long_message_to_split = true;
        lsp_doc_border = true;
      };

      views = {
        cmdline_popup = {
          border = {
            style = "bold";
          };
          scrollbar = false;
        };
        popupmenu = {
          border = {
            style = "bold";
          };
          scrollbar = false;
        };
        mini = {
          border = {
            style = "bold";
          };
          scrollbar = false;
        };
        hover = {
          border = {
            style = "bold";
          };
          scrollbar = false;
        };
        popup = {
          border = {
            style = "bold";
          };
          scrollbar = false;
        };
        split = {
          scrollbarSet = false;
          scrollbar = false;
        };
        notify = {
          border = {
            style = "bold";
          };
          scrollbar = false;
        };
        messages = {
          border = {
            style = "bold";
          };
        };
        virtualtext = {
          border = {
            style = "bold";
          };
        };
      };

    };
  };

  programs.nixvim.keymaps = [
    {
      key = "<leader>nh";
      mode = [ "n" ];
      action = "<cmd>Noice history<CR>";
      options.desc = "History";
    }
    {
      key = "<leader>nl";
      mode = [ "n" ];
      action = "<cmd>Noice last<CR>";
      options.desc = "Last Msg";
    }
    {
      key = "<leader>na";
      mode = [ "n" ];
      action = "<cmd>Noice all<CR>";
      options.desc = "All Msg";
    }
    {
      key = "<leader>nd";
      mode = [ "n" ];
      action = "<cmd>Noice dismiss<CR>";
      options.desc = "Dismiss";
    }
    {
      key = "<leader>np";
      mode = [ "n" ];
      action = "<cmd>Noice pick<CR>";
      options.desc = "Pick";
    }
  ];
}
