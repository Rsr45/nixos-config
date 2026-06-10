{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.helium-flake.homeModules.default
  ];

  programs.helium = {
    enable = true;

    # Optional: override the package
    # package = pkgs.helium;

    # 🚩 Flags - Command-line arguments always passed to Helium
    # flags = [
    #   "--enable-features=TouchpadOverscrollHistoryNavigation"
    #   "--start-maximized"
    # ];

    # Optional: user policies (best-effort, use NixOS module for critical policies)
    # policies = {
    #   "BrowserSignin" = 0;
    # };
  };
}
