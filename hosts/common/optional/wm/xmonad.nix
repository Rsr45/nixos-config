{ inputs, ... }:
{
  services.xserver.windowManager.xmonad = {
    enable = false;
    enableContribAndExtras = true;
    config = builtins.readFile ./xmonad.hs;
    ghcArgs = [
      "-hidir /tmp" # place interface files in /tmp, otherwise ghc tries to write them to the nix store
      "-odir /tmp" # place object files in /tmp, otherwise ghc tries to write them to the nix store
      "-i${inputs.xmonad-contexts}" # tell ghc to search in the respective nix store path for the module
    ];
    extraPackages = haskellPackages: [
      haskellPackages.xmonad-contrib
      haskellPackages.monad-logger
    ];
  };
}
