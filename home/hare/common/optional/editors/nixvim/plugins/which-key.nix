{ ... }:

{
  programs.nixvim.plugins = {
    which-key = {
      enable = true;
      settings = {
        preset = "classic";
        delay = 2000;
        icons = {
          breadcrumb = " ";
          separator = ":";
        };
      };
    };
  };
}
