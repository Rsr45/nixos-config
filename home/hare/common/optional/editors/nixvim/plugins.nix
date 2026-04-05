{
  pkgs,
  ...
}:

{
  imports = [
    ./plugins/mini.nix
    ./plugins/mini-clue.nix
    # ./plugins/mini-jump2d.nix
    ./plugins/flash.nix
    ./plugins/picker.nix
    ./plugins/oil.nix
    ./plugins/snacks.nix
    ./plugins/obsidian.nix
    ./plugins/markdown.nix
    # ./plugins/norg.nix
    ./plugins/org.nix
    ./plugins/icons.nix
    ./plugins/git.nix
  ];

  programs.nixvim = {
    plugins = {
    };

    extraPlugins = with pkgs.vimPlugins; [
      miasma-nvim
      dracula-nvim
      vim-moonfly-colors
      gruvbox-nvim
      gruvbox-material
      pywal-nvim
      doom-one-nvim

      (pkgs.vimUtils.buildVimPlugin {
        name = "neopywal";
        src = pkgs.fetchurl {
          url = "https://github.com/RedsXDD/neopywal.nvim/archive/refs/tags/v2.6.0.tar.gz";
          hash = "sha256-NkG+Ek5RdSc+HdBAmJG+833JzDeOLvXkKVm4xXdjb9s=";
        };
      })
    ];
  };
}
