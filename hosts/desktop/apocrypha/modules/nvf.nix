{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        theme = {
          enable = true;
          name = "gruvbox";
          style = "dark";
        };

        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;

        languages = {
          enableFormat = true;
          enableLSP = true;
          enableTreesitter = true;

          nix.enable = true;
          nu.enable = true;
          ts.enable = true;
          rust.enable = true;
          css.enable = true;
          bash.enable = true;
          markdown.enable = true;
        };
      };
    };
  };
}
