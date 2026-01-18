{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.nixvim.plugins.mini = {
    mockDevIcons = true;
    modules.icons = { };
  };
}
