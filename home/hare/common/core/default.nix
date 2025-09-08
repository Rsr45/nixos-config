#FIXME: Move attrs that will only work on linux to nixos.nix
#FIXME: if pulling in homemanager for isMinimal maybe set up conditional for some packages
{
  config,
  lib,
  pkgs,
  hostSpec,
  ...
}:
let
  platform = if hostSpec.isDarwin then "darwin" else "nixos";
in
{
  imports = lib.flatten [
    (map lib.custom.relativeToRoot [
      "modules/common/host-spec.nix"
      # "modules/home"
    ])
    ./${platform}.nix
    ./xdg.nix
    ./wezterm.nix
    ./urxvt.nix
    ./gtk.nix
    ./qt.nix
    # ./zsh
    # ./nixvim
    # ./bash.nix
    ./bat.nix
    # ./btop.nix
    # ./direnv.nix
    # ./fonts.nix
    # ./git.nix
    # ./kitty.nix
    # ./screen.nix
    # ./ssh.nix
    # ./zoxide.nix
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
      SHELL = "nu";
      TERM = "wezterm";
      TERMINAL = "wezterm";
      VISUAL = "vim";
      EDITOR = "vim";
      # MANPAGER = "batman";
    };
    preferXdgDirectories = true;
  };

  home.packages = builtins.attrValues {
    inherit (pkgs)
      # Packages that don't have custom configs go here
      copyq # clipboard manager
      coreutils # basic gnu utils
      curl
      eza # ls replacement
      dust # disk usage
      fd # tree style ls
      findutils # find
      fzf # fuzzy search
      jq # json pretty printer and manipulator
      nix-tree # nix package tree viewer
      neofetch # fancier system info than pfetch
      ncdu # TUI disk usage
      pciutils
      pfetch # system info
      pre-commit # git hooks
      p7zip # compression & encryption
      ripgrep # better grep
      steam-run # for running non-NixOS-packaged binaries on Nix
      usbutils
      tree # cli dir tree viewer
      unzip # zip extraction
      unrar # rar extraction
      wev # show wayland events. also handy for detecting keypress codes
      wget # downloader
      xdg-utils # provide cli tools such as `xdg-mime` and `xdg-open`
      xdg-user-dirs
      yq-go # yaml pretty printer and manipulator
      zip # zip compression
      vimiv-qt
      ;
  };

  programs.btop.enable = true;
  programs.mpv.enable = true;
  programs.lazygit.enable = true;

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
