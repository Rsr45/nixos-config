{
  config,
  lib,
  ...
}:

let
  browser-theme = import ./ultima-mod.nix { inherit config lib; };
in
''
  ${browser-theme}
''
