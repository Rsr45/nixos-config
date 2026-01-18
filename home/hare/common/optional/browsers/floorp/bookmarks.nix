{ ... }:
{
  programs.floorp.profiles.default.bookmarks = {
    force = true;
    settings = [
      {
        name = "Wikipedia";
        tags = [ "wiki" ];
        keyword = "wiki";
        url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
      }
      {
        name = "FMHY";
        tags = [
          "wiki"
          "privacy"
        ];
        url = "https://fmhy.net/";
      }
      {
        name = "Documentations";
        toolbar = false;
        bookmarks = [
          {
            name = "NixOS";
            url = "https://wiki.nixos.org/";
            tags = [
              "nix"
              "wiki"
            ];
          }
          {
            name = "Home Manager";
            url = "https://nix-community.github.io/home-manager/options.xhtml";
            tags = [
              "nix"
              "wiki"
            ];
          }
          {
            name = "NixVim";
            url = "https://nix-community.github.io/nixvim/";
            tags = [
              "nix"
              "wiki"
            ];
          }
          {
            name = "Nvf";
            url = "https://notashelf.github.io/nvf/options.html";
            tags = [
              "nix"
              "wiki"
            ];
          }
          {
            name = "Stylix";
            url = "https://stylix.danth.me/";
            tags = [
              "nix"
              "wiki"
            ];
          }
        ];
      }
      {
        name = "Games";
        toolbar = false;
        bookmarks = [
          {
            name = "FMHY";
            url = "https://fmhy.net/";
          }
          {
            name = "Fitgirl";
            url = "https://fitgirl-repacks.site/";
          }
          {
            name = "DODI";
            url = "https://www.1337x.to/user/DODI/";
          }
          {
            name = "GOG";
            url = "https://www.gog-games.to/";
          }
          {
            name = "Xatab";
            url = "https://byxatab.com/";
          }
          {
            name = "Elamigos";
            url = "https://elamigos.site/";
          }
          {
            name = "Itch.io";
            url = "https://itch.io/games/new-and-popular/featured/free";
          }
          {
            name = "Myrient";
            url = "https://myrient.erista.me/";
          }
          {
            name = "Vimm's Lair";
            url = "https://vimm.net/vault";
          }
        ];
      }
    ];
  };
}
