# IMPORTANT: This is used by NixOS and nix-darwin so options must exist in both!
{
  inputs,
  outputs,
  config,
  lib,
  pkgs,
  isDarwin,
  ...
}:
let
  platform = if isDarwin then "darwin" else "nixos";
  platformModules = "${platform}Modules";
in
{
  imports = lib.flatten [
    inputs.home-manager.${platformModules}.home-manager
    inputs.sops-nix.${platformModules}.sops

    (map lib.custom.relativeToRoot [
      "modules/common"
      "hosts/common/core/${platform}.nix"
      "hosts/common/core/sops.nix"
      "hosts/common/users/admin"
      "hosts/common/users/admin/${platform}.nix"
      "hosts/common/users/hare"
      "hosts/common/users/hare/${platform}.nix"
      "hosts/common/users/vahlok"
      "hosts/common/users/vahlok/${platform}.nix"
    ])
  ];

  #
  # ========== Core Host Specifications ==========
  #
  hostSpec = {
    adminUserName = "admin";
    secondUserName = "vahlok";
    username = "hare"; # edit it so it is easier for multiple user machine setup
    handle = "Rsr45";
    # inherit (inputs.nix-secrets)
    #   domain
    #   email
    #   userFullName
    #   networking
    #   ;
  };

  networking.hostName = config.hostSpec.hostName;

  # environment.systemPackages = [ pkgs.openssh ];

  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "bk";
  home-manager.useUserPackages = true;

  #
  # ========== Overlays ==========
  #
  nixpkgs = {
    # overlays = [
    #   outputs.overlays.default
    # ];
    config = {
      allowUnfree = true;
    };
  };

  #
  # ========== Nix Nix Nix ==========
  #
  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # See https://jackson.dev/post/nix-reasonable-defaults/
      connect-timeout = 5;
      log-lines = 25;
      min-free = 128000000; # 128MB
      max-free = 1000000000; # 1GB

      trusted-users = [ "@wheel" ];
      auto-optimise-store = true;
      warn-dirty = false;

      allow-import-from-derivation = true;

      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
}
