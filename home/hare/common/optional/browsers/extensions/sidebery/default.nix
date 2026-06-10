{
  config,
  lib,
  ...
}: let
  rest =
    (import ./containers.nix {inherit config;})
    // (import ./settings.nix {inherit config;})
    // (import ./keybindings.nix {inherit config;})
    // (import ./sidebar.nix {inherit config;});
in
  rest
  // {
  }
