{ ... }:
{
  programs.nvf.settings = {
    vim = {
      globals = {
        mapleader = " ";
        maplocalleader = " ";
      };

      options = {
        # showmode = false;
        # number = true;
        # cursorline = true;
        # cursorlineopt = "both";
        # background = "dark";
        # breakindent = true;
        # wrap = true;
        # inccommand = "split";
        # shell = "bash";
      };

      preventJunkFiles = true;
      searchCase = "smart";

      # spellcheck = {
      #   enable = true;
      #   languages = [
      #     "en"
      #     "fr"
      #     "de"
      #     "tr"
      #   ];
      #   programmingWordlist.enable = true;
      # };

      utility.direnv.enable = true;
      utility.images.image-nvim.enable = true;
      utility.images.image-nvim.setupOpts.backend = "kitty";
      utility.images.img-clip.enable = true;

      binds.whichKey.enable = true;
    };
  };
}
