{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.nixvim.plugins.mini.modules.statusline = { };
}
