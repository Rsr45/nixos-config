{ ... }:
{
  programs.nixvim.plugins.neorg = {
    enable = true;
    settings = {
      load = {
        "core.defaults" = { };
        "core.concealer" = {
          config = {
            icon_preset = "diamond";
          };
        };
        "core.dirman" = {
          config = {
            workspaces = {
              default = "~/Personal/Notes/";
            };
          };
        };
        "core.export" = { };
        # "core.export.html" = { };
        # "core.export.markdown" = { };
      };
    };
  };
}
