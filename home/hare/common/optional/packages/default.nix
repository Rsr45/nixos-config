{
  pkgs,
  config,
  inputs,
  ...
}:
{
  home.packages = with pkgs; [
    openmw
    ffmpeg
    ffmpegthumbnailer
    gifski
    xclip
    wl-clipboard
    ps3iso-utils
    ps3-disc-dumper
    libnotify
    pwvucontrol
    grim
    slurp
    osu-lazer-bin
    quodlibet-full
    xwayland-satellite
    swww
    tmux-sessionizer
    calibre
    dysk
    duf
    wev
    rmpc
    inputs.quickshell.packages."${system}".default
    just
    mask
    xh
    du-dust
    dua
    hyperfine
    xan
    uutils-coreutils
    odin
    # retroarch-full
    # (retroarch.withCores (
    #   cores: with cores; [
    #   ]
    # ))
    ppsspp
    # duckstation # removed
    mednafen
    pcsx2
    # rpcs3
    dolphin-emu
    cemu
    melonDS
    # azahar
    flycast
    libsecret
  ];
  # programs.mbsync.enable = true;
  # programs.msmtp.enable = true;
  programs = {
    bat.enable = true;
    nnn.enable = true;
    ranger.enable = true;
    joshuto.enable = true;
    lf.enable = true;
    gitui.enable = true;
    zellij = {
      enable = true;
      # settings = {};
    };
    ripgrep.enable = true;
    ripgrep-all.enable = true;
    fd.enable = true;
  };
  programs.qutebrowser = {
    enable = true;
    settings = {
      colors = {
        webpage.darkmode.enabled = true;
      };
      tabs = {
        favicons.show = "never";
        background = false;
      };
    };
  };

}
