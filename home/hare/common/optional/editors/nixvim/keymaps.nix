{ lib, ... }:
{
  programs.nixvim.keymaps = [
    ## Code
    {
      key = "<leader>cf";
      mode = [
        "n"
        "v"
      ];
      action.__raw = ''
        function()
          require("conform").format({
            lsp_fallback = true,
            async = true,
            timeout_ms = 1000,
          })
        end
      '';
      options.desc = "Format Buffer/Region";
    }
    {
      key = "<leader>cx";
      mode = [ "n" ];
      action.__raw = "function() if vim.fn.getloclist(0, {winid=1}).winid ~= 0 then vim.cmd('lclose') else vim.diagnostic.setloclist() end end";
      options.desc = "Diagnostic List";
    }
    ## File
    {
      key = "<leader>fs";
      mode = [ "n" ];
      action = "<cmd>update<CR>";
      options.desc = "Save file";
    }
    ## Quality of Life
    {
      key = "<leader>tl";
      mode = "n";
      action = "<cmd>set rnu!<CR>";
      options.desc = "Line number";
    }
    {
      key = "<leader>ts";
      mode = "n";
      action = "<cmd>set spell!<CR>";
      options.desc = "Toggle Spell";
    }
    # {
    #   key = "<S-Down>";
    #   mode = "v";
    #   action = ":m '>+1<CR>gv=gv";
    #   options.desc = "Moves Line Down";
    # }
    # {
    #   key = "<S-Up>";
    #   mode = "v";
    #   action = ":m '<-2<CR>gv=gv";
    #   options.desc = "Moves Line Up";
    # }
    # {
    #   key = "<C-d>";
    #   mode = "n";
    #   action = "<C-d>zz";
    #   options.desc = "Scroll Down";
    # }
    # {
    #   key = "<C-u>";
    #   mode = "n";
    #   action = "<C-u>zz";
    #   options.desc = "Scroll Up";
    # }
    # {
    #   key = "n";
    #   mode = "n";
    #   action = "nzzzv";
    #   options.desc = "Next Search Result";
    # }
    # {
    #   key = "N";
    #   mode = "n";
    #   action = "Nzzzv";
    #   options.desc = "Previous Search Result";
    # }
    # {
    #   key = "<Down>";
    #   mode = "n";
    #   action = "v:count == 0 ? 'gj' : 'j'";
    #   options = {
    #     expr = true;
    #     silent = true;
    #   };
    # }
    # {
    #   key = "<Up>";
    #   mode = "n";
    #   action = "v:count == 0 ? 'gk' : 'k'";
    #   options = {
    #     expr = true;
    #     silent = true;
    #   };
    # }
    # ----------- Clipbord -----------------
    {
      key = "<leader>y";
      mode = [
        "n"
        "x"
        "v"
      ];
      action = "\"+y";
      options = {
        noremap = true;
        silent = true;
        desc = "Yank to clipboard";
      };
    }
    {
      key = "<leader>Y";
      mode = [
        "n"
        "x"
        "v"
      ];
      action = "\"+yy";
      options = {
        noremap = true;
        silent = true;
        desc = "Yank line to clipboard";
      };
    }
    {
      key = "<C-a>";
      mode = [
        "n"
        "x"
        "v"
      ];
      action = "gg0vG$";
      options = {
        noremap = true;
        silent = true;
        desc = "Select All";
      };
    }
    {
      key = "<leader>p";
      mode = [
        "n"
        "x"
        "v"
      ];
      action = "\"+p";
      options = {
        noremap = true;
        silent = true;
        desc = "Paste from clipboard";
      };
    }
    {
      key = "<C-p>";
      mode = "i";
      action = "<C-r><C-p>+";
      options = {
        noremap = true;
        silent = true;
        desc = "Paste from clipboard within insert mode";
      };
    }
    {
      key = "<leader>P";
      mode = "x";
      action = "\"_dP";
      options = {
        noremap = true;
        silent = true;
        desc = "Paste over selection without erasing unnamed register";
      };
    }
  ];
}
