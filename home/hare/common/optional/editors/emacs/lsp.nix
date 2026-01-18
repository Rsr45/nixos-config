{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.file = {
    "doom-emacs/.local/etc/lsp/lua-language-server/bin/lua-language-server" = {
      source = "${pkgs.lua-language-server}/bin/lua-language-server";
    };
  };
}
