{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.nixvim.plugins.snacks = {
    enable = true;
    settings = {
      statuscolumn = {
        enabled = false;
        left = [
          "mark"
          "sign"
          "fold"
          "git"
        ];
        right = [
        ];
      };
      indent.enabled = true;
      git = {
        enabled = true;
      };
      lazygit = {
        enabled = true;
      };
      notifier = {
        enabled = true;
      };
      image = {
        enabled = true;
      };
      zen = {
        enabled = true;
      };
      picker = {
        enabled = true;
        layout = {
          preview = "ivy";
        };
        preset = "ivy";
      };
      words = {
        enabled = true;
      };
    };
  };
}
