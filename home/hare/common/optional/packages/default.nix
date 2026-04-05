{
  pkgs,
  inputs,
  ...
}:
{
  home.packages = with pkgs; [
    # RSS Feed
    # bulletty # cool but no script
    newsboat
    # Network/
    # speedtest-cli
    # bluetui
    # impala
    # Music
    cmus
    kew
    # pulsemeeter
    crosspipe
    # Disk
    ncdu
    # Web
    nyaa
    lynx
    readability-cli
    # openmw

    ffmpeg
    ffmpegthumbnailer
    gifski

    xclip
    wl-clipboard
    ps3iso-utils
    ps3-disc-dumper
    kdePackages.kruler
    libnotify
    pwvucontrol
    ## Application Launchers
    rofi
    warp
    fsel
    # vicinae
    python3
    # libxml2
    # just
    ## Screenshot and such
    grim
    maim
    slurp
    slop
    # OCR
    tesseract
    # Wall
    inputs.thumbpick.packages.${pkgs.stdenv.hostPlatform.system}.default
    # osu-lazer-bin
    audacious
    # smassh
    xwayland-satellite
    swww
    tmux-sessionizer
    # calibre
    # disk space calc
    dysk
    dust
    duf

    wev
    # rmpc
    brave
    wiremix
    doxx
    broot
    trashy
    # --- Bar/Framework ---
    # inputs.quickshell.packages.${system}.default
    # inputs.noctalia.packages.${system}.default
    quickshell
    # inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    # inputs.caelestia-shell.packages.${pkgs.stdenv.hostPlatform.system}.with-cli
    # --- MISC ---
    # just
    # mask
    # xh
    # du-dust
    dua
    # hyperfine
    # xan
    # uutils-coreutils
    # odin
    # cmake
    # libtool
    # graphviz
    # python314
    imagemagick
    # ghostscript
    # mermaid-cli
    # nodejs
    # mlocate
    # --- 3DR ---
    freecad
    # blender
    # blender-hip set  # config.rocmSupport = true; or use pkgsRocm.blender
    # --- Languages ---
    # --- LSP ---
    # nixd
    # lua-language-server
    # clang-tools
    # gopls
    # gomodifytags
    # gotests
    # gore
    # haskell-language-server # haskell
    # haskellPackages.hoogle # haskell
    # cabal-install # haskell
    # ktlint # kotlin
    # sbcl # common-lisp
    # rust-analyzer
    # pyflakes
    # isort
    # pipenv
    # nosetests
    # pytest
    # --- FMT ---
    # stylua
    # ocamlformat
    # swift-format
    # tidyp
    # jsbeautifier
    # shfmt
    # black
    # --- Lint ---
    # stylelint
    # shellcheck
    # --- EMU ---
    # retroarch-full
    (retroarch.withCores (
      cores: with cores; [
        beetle-psx-hw
        pcsx2
        ppsspp
      ]
    ))
    (heroic.override {
      extraPkgs =
        pkgs': with pkgs'; [
          gamescope
          gamemode
        ];
    })
    ppsspp
    # duckstation # removed
    # mednafen
    pcsx2
    # rpcs3
    # dolphin-emu
    # cemu
    # melonDS
    # azahar
    # flycast
    libsecret
    # ranger
    # lf
    # notes
    basalt
    bibiman
    bandwhich
    kalker
    television
    wiper
    trippy
  ];
  # programs.mbsync.enable = true;
  # programs.msmtp.enable = true;
  programs = {
    # bat.enable = true;
    # nnn.enable = true;
    # ranger.enable = false;
    # joshuto.enable = true;
    # lf.enable = true;
    # gitui.enable = true;
    # broot.enable = true;
    # zellij = {
    #   enable = true;
    #   # settings = {};
    # };
    ripgrep.enable = true;
    ripgrep-all.enable = true;
    fd.enable = true;
  };
  services.swww.enable = true;
  programs.lutris = {
    enable = true;
    defaultWinePackage = pkgs.proton-ge-bin;
    protonPackages = with pkgs; [ proton-ge-bin ];
    extraPackages = with pkgs; [
      mangohud
      winetricks
      gamescope
      gamemode
      umu-launcher
    ];
  };
}
