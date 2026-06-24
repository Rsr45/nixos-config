{
  pkgs,
  inputs,
  ...
}: {
  # programs.emacs = {
  #   enable = true;
  #   package = pkgs.emacs; # replace with pkgs.emacs-gtk if desired
  #   extraPackages = epkgs: [
  #     epkgs.nix-mode
  #     epkgs.nixfmt
  #   ];
  #   extraConfig = ''
  #     (setq standard-indent 2)
  #   '';
  # };

  home.packages = with pkgs; [
    emacs-gtk
    # vterm etc
    cmake
    gcc
    libtool
    # req
    graphviz
    plantuml
    # lsp
    marksman
    nixd
    lua-language-server
    texlab
    zotero
    poppler-utils
    vips
    (aspellWithDicts (
      dicts:
        with dicts; [
          en
          en-computers
          en-science
          tr
        ]
    ))
  ];
}
