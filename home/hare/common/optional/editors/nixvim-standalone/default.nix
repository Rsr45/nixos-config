{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  home.packages = with pkgs; [
    inputs.nixvim-config.packages.${pkgs.stdenv.hostPlatform.system}.default
    nixd
  ];
}
