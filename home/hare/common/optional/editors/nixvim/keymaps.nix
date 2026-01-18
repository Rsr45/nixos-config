{ ... }:
{
  programs.nixvim.keymaps = [
    ## Code
    # {
    #   key = "<leader>e";
    #   mode = [ "n" ];
    #   action = "vim.diagnostic.open_float";
    #   options.desc = "Open floating diagnostic message";
    # }
    {
      key = "<leader>cf";
      mode = [
        "n"
        "v"
      ];
      action = ''
        function()
          require("conform").format({
            lsp_fallback = true,
             async = false,
             timeout_ms = 1000,
          })
        end,
      '';
      options.desc = "Format buffer/region";
    }
    {
      key = "<leader>cx";
      mode = [ "n" ];
      action = "<cmd>Trouble diagnostics<CR>";
      options.desc = "List errors";
    }
    ## File
    {
      key = "<leader>fs";
      mode = [ "n" ];
      action = "<cmd>update<CR>";
      options.desc = "Save file";
    }
    {
      key = "<leader>ff";
      mode = [ "n" ];
      action = "<cmd>lua Snacks.picker.files()<CR>";
      options.desc = "Find Files";
    }
    {
      key = "<leader>.";
      mode = [ "n" ];
      action = "<cmd>lua Snacks.picker.files()<CR>";
    }
    ## Buffer
    {
      key = "<leader>,";
      mode = [ "n" ];
      action = "<cmd>lua Snacks.picker.buffers()<CR>";
    }
    {
      key = "<leader>bb";
      mode = [ "n" ];
      action = "<cmd>lua Snacks.picker.buffers()<CR>";
    }
    ## Search
    {
      key = "<leader>ss";
      mode = [ "n" ];
      action = "<cmd>lua Snacks.picker.lines()<CR>";
    }
    {
      key = "<leader>sb";
      mode = [ "n" ];
      action = "<cmd>lua Snacks.picker.lines()<CR>";
    }
    {
      key = "<leader>sB";
      mode = [ "n" ];
      action = "<cmd>lua Snacks.picker.grep_buffers()<CR>";
    }
    {
      key = "<leader>su";
      mode = [ "n" ];
      action = "<cmd>lua Snacks.picker.undo()<CR>";
    }
    ## window
    {
      key = "<leader>ws";
      mode = [ "n" ];
      action = "<cmd>split<CR>";
      options.desc = "window-split";
    }
    {
      key = "<leader>wv";
      mode = [ "n" ];
      action = "<cmd>vsplit<CR>";
      options.desc = "window-vsplit";
    }
    {
      key = "<leader>wn";
      mode = [ "n" ];
      action = "<cmd>new<CR>";
      options.desc = "window-new";
    }
    {
      key = "<leader>wc";
      mode = [ "n" ];
      action = "<cmd>close<CR>";
      options.desc = "window-close";
    }
    ## Flash
    {
      key = "s";
      mode = [
        "n"
        "x"
        "o"
      ];
      action = "<cmd>lua require(\"flash\").jump()<cr>";
    }
    {
      key = "S";
      mode = [
        "n"
        "x"
        "o"
      ];
      action = "<cmd>lua require(\"flash\").treesitter()<cr>";
    }
    {
      key = "r";
      mode = [
        "o"
      ];
      action = "<cmd>lua require(\"flash\").remote()<cr>";
    }
    {
      key = "R";
      mode = [
        "x"
        "o"
      ];
      action = "<cmd>lua require(\"flash\").treesitter_search()<cr>";
    }
    {
      key = "<C-s>";
      mode = [
        "c"
      ];
      action = "<cmd>lua require(\"flash\").toggle()<cr>";
    }
    {
      key = "<c-space>";
      mode = [
        "n"
        "x"
        "o"
      ];
      action = ''
        function()
          require("flash").treesitter({
            actions = {
              ["c-space"] = "next",
              ["<BS>"] = "prev"
            }
          })
        end,
      '';
    }
    ## Oil
    {
      key = "<leader>-";
      mode = "n";
      action = "<cmd>Oil .<CR>";
      options = {
        noremap = true;
        desc = "Open Nvim root Directory";
      };
    }
    {
      key = "-";
      mode = "n";
      action = "<cmd>Oil<CR>";
      options = {
        noremap = true;
        desc = "Open Parent Directory";
      };
    }
    ## Git
    {
      key = "<leader>gg";
      mode = "n";
      action = "<cmd>Neogit<CR>";
      options = {
        desc = "Open Neogit";
      };
    }
    ## Quality of Life
    {
      key = "<S-Down>";
      mode = "v";
      action = ":m '>+1<CR>gv=gv";
      options.desc = "Moves Line Down";
    }
    {
      key = "<S-Up>";
      mode = "v";
      action = ":m '<-2<CR>gv=gv";
      options.desc = "Moves Line Up";
    }
    {
      key = "<C-d>";
      mode = "n";
      action = "<C-d>zz";
      options.desc = "Scroll Down";
    }
    {
      key = "<C-u>";
      mode = "n";
      action = "<C-u>zz";
      options.desc = "Scroll Up";
    }
    {
      key = "n";
      mode = "n";
      action = "nzzzv";
      options.desc = "Next Search Result";
    }
    {
      key = "N";
      mode = "n";
      action = "Nzzzv";
      options.desc = "Previous Search Result";
    }
    {
      key = "<Down>";
      mode = "n";
      action = "v:count == 0 ? 'gj' : 'j'";
      options = {
        expr = true;
        silent = true;
      };
    }
    {
      key = "<Up>";
      mode = "n";
      action = "v:count == 0 ? 'gk' : 'k'";
      options = {
        expr = true;
        silent = true;
      };
    }
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
    ## Buffer
    {
      key = "<leader><leader>[";
      mode = "n";
      action = "<cmd>bprev<CR>";
      options.desc = "Previous Buffer";
    }
    {
      key = "<leader><leader>]";
      mode = "n";
      action = "<cmd>bnext<CR>";
      options.desc = "Next Buffer";
    }
    {
      key = "<leader><leader>l";
      mode = "n";
      action = "<cmd>b#<CR>";
      options.desc = "Last Buffer";
    }
    {
      key = "<leader><leader>d";
      mode = "n";
      action = "<cmd>bdelete<CR>";
      options.desc = "Delete Buffer";
    }
  ];
}
