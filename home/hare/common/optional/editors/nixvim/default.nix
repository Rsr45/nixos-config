{
  inputs,
  ...
}:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./keymaps.nix
    ./languages.nix
    ./plugins.nix
  ];

  programs.nixvim = {
    enable = true;
    viAlias = false;
    vimAlias = false;
    extraConfigLuaPre =''
      vim.opt.cpoptions:append('I')
    '';
    opts = {
      # === Indent ===
      # vim.opt.cpoptions:append('I')
      expandtab = false;
      smarttab = true;
      smartindent = true;
      autoindent = true;
      tabstop = 8;
      softtabstop = 8;
      shiftwidth = 8;

      showmode = false;
      number = true;
      relativenumber = true;
      cursorline = true;
      background = "dark";
      wrap = true;
      inccommand = "split";
      spell = false;
      shell = "bash";
      winborder = "bold";
      # laststatus = 3;
    };

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    colorscheme = "neopywal";

    clipboard.providers = {
      wl-copy.enable = true;
      xclip.enable = true;
    };
  };
}
