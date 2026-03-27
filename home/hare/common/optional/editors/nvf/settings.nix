{ ... }:
{
  programs.nvf.settings = {
    vim = {
      globals = {
        mapleader = " ";
        maplocalleader = " ";
      };

      options = {
        showmode = false;
        number = true;
        relativenumber = false;
        cursorline = true;
        cursorlineopt = "both";
        background = "dark";
        breakindent = true;
        wrap = true;
        inccommand = "split";
        shell = "bash";
      };

      preventJunkFiles = true;
      searchCase = "smart";

      spellcheck = {
        enable = true;
        languages = [
          "en"
          "fr"
          "de"
          "tr"
        ];
        programmingWordlist.enable = false;
      };

      utility.direnv.enable = true;
      utility.images.image-nvim.enable = true;
      utility.images.image-nvim.setupOpts.backend = "kitty";

      utility.motion.precognition.enable = false;
      utility.motion.hop.enable = false;
      utility.motion.hop.mappings.hop = "s";
      utility.motion.flash-nvim.enable = true;
      utility.motion.flash-nvim = {
        mappings = {
          jump = "s";
          remote = "";
          toggle = "";
          treesitter = "";
          treesitter_search = "";
        };
        setupOpts = {
          modes.char.jump_labels = true;
        };
      };

      binds.whichKey.enable = true;

      fzf-lua.enable = true;
      fzf-lua.profile = "skim";

      utility.multicursors.enable = true;
    };
  };
}
