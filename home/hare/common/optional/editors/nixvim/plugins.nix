{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./plugins/which-key.nix
  ];

  programs.nixvim = {
    plugins = { };

    extraPlugins = with pkgs.vimPlugins; [
      miasma-nvim
      dracula-nvim
      vim-moonfly-colors
      gruvbox-nvim
      gruvbox-material
      pywal-nvim
    ];
  };
}
