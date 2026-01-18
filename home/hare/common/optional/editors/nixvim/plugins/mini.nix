{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.nixvim.plugins = {
    mini.enable = true;
    mini.modules = {
      comment = { };
      bracketed = { };
      operators = { };
      ai = { };
      basics = { };
      surround = {
        mappings = {
          add = "gsa";
          delete = "gsd";
          find = "gsf";
          find_left = "gsF";
          highlight = "gsh";
          replace = "gsr";
          update_n_lines = "gsn";
        };
      };
      pairs = { };
      # statusline = { };
      pick = { };
      # snippets = { };
      # completion = { };
    };
  };
}
