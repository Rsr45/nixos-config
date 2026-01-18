{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.nixvim.plugins.lualine = {
    enable = true;
    settings = {
      options = {
        icons_enabled = true;
        component_separators = "";
        section_separators = "";
      };
    };
  };
}
