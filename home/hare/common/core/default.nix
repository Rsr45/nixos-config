#FIXME: Move attrs that will only work on linux to nixos.nix
{
  config,
  lib,
  pkgs,
  hostSpec,
  ...
}: let
  platform =
    if hostSpec.isDarwin
    then "darwin"
    else "nixos";
in {
  imports = lib.flatten [
    (map lib.custom.relativeToRoot [
      "modules/common/host-spec.nix"
      # "modules/home"
    ])
    ./${platform}.nix
    ## Directory set, and bookmarks
    ./xdg.nix
    ./gtk.nix
    ## UI
    ./cursor.nix
    ./qt.nix
    ./kvantum.nix
    ## Shell
    ./aliases.nix
    ./bash.nix
    ./fish.nix
    ./nu.nix
    ## CLI
    ./bat.nix
    # ./btop.nix
    # ./direnv.nix
    # ./fonts.nix
    # ./git.nix
    ./kitty.nix
    # ./screen.nix
    # ./ssh.nix
    ./zoxide.nix
    ./eza.nix
    ./starship.nix
  ];

  inherit hostSpec;

  services.ssh-agent.enable = true;

  home = {
    username = lib.mkDefault config.hostSpec.username;
    homeDirectory = lib.mkDefault config.hostSpec.home;
    stateVersion = lib.mkDefault "24.11";
    sessionPath = [
      "$HOME/.local/bin"
    ];
    sessionVariables = {
      FLAKE = "$HOME/nixos-config";
      EDITOR = "vi";
    };
    preferXdgDirectories = true;
  };

  home.packages = with pkgs; [
    # Packages that don't have custom configs go here
    coreutils
    findutils
    pciutils
    usbutils
    xdg-utils
    xdg-user-dirs
    curl
    dua # disk usage with  interactive mode that works like ncdu
    dust # disk usage
    dysk # fs disk usage
    wl-clipboard
    nix-tree # nix package tree viewer
    hydra-check
    steam-run
    wev
    wget
    jq
  ];

  programs.btop.enable = true;
  programs.mpv.enable = true;
  programs.feh.enable = true;

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
    };
  };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
