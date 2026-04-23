{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.orgmode = {
      enable = true;
      settings = {
        # org_agenda_files = "~/orgfiles/**/*";
        # org_default_notes_file = "~/orgfiles/refile.org";
        org_agenda_files = "~/Personal/Notes/**/*";
        org_default_notes_file = "~/Personal/Notes/refile.org";
        org_adapt_indentation = false;
        org_startup_indented = true;
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      org-roam-nvim

      (pkgs.vimUtils.buildVimPlugin {
        name = "org-modern";
        src = pkgs.fetchFromGitHub {
          owner = "danilshvalov";
          repo = "org-modern.nvim";
          rev = "c024900b7ee78a0274036025569b47001ef3e6aa";
          hash = "sha256-TYs3g5CZDVXCFXuYaj3IriJ4qlIOxQgArVOzT7pqkqs=";
        };
      })

      (pkgs.vimUtils.buildVimPlugin {
        name = "org-bullets";
        src = pkgs.fetchFromGitHub {
          owner = "nvim-orgmode";
          repo = "org-bullets.nvim";
          # rev = "21437cfa99c70f2c18977bffd423f912a7b832ea";
          # hash = "sha256-/l8IfvVSPK7pt3Or39+uenryTM5aBvyJZX5trKNh0X0=";
          rev = "503fe053550879cc202086a40454e46a87c41ddb";
          hash = "sha256-Tgeqr/Zd1hJXXaln4XWGS5aZqypnpfNxgO/+pQVk7jg=";
        };
      })

    ];

    # require('org-bullets').setup()
    extraConfigLua = ''
      require('org-roam').setup({
          directory = '~/Personal/Notes/roam',
      })


      local Menu = require("org-modern.menu")

      require("orgmode").setup({
          ui = {
              menu = {
                  handler = function(data)
                      Menu:new({
                          window = {
                              margin = { 1, 0, 1, 0 },
                              padding = { 0, 1, 0, 1 },
                              title_pos = "center",
                              border = "single",
                              zindex = 1000,
                          },
                          icons = {
                              separator = "➜",
                          },
                      }):open(data)
                  end,
              },
          },
      })
    '';
  };
}
