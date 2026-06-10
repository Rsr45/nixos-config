{
  config,
  lib,
  ...
}:

let
  youtube = import ./youtube.nix { inherit config lib; };
  searxng = import ./searxng.nix { inherit config lib; };
  sidebar = import ./sidebery.nix { inherit config lib; };
in
''
  * {
    border-radius: 0px !important;
  }


  ${youtube}

  ${searxng}

  ${sidebar}
''
