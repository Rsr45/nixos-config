{ ... }:
{
  programs.wallust.enable = true;

  xdg.configFile = {
    "wallust/templates" = {
      source = ./wal-templates;
      recursive = true;
    };
    "wallust/colorschemes" = {
      source = ./wal-colorschemes;
      recursive = true;
    };
  };
}
