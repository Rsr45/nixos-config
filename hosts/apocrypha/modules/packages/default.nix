{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ffmpeg
    ffmpegthumbnailer
    gifski
    xclip
    wl-clipboard
    ps3iso-utils
    ps3-disc-dumper
    playerctl
    dunst
    libnotify
    pwvucontrol
    grim
    slurp
    osu-lazer-bin
    quodlibet-full
    pcsx2
    xwayland-satellite
    swww
    tmux-sessionizer
    calibre
    dysk
    duf
    wev
    rmpc
  ];
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
      auto_save.session = true;
    };
  };
  programs.bat.enable = true;
  programs.nnn.enable = true;
  programs.ranger.enable = true;
  programs.joshuto.enable = true;
  programs.lf.enable = true;
  programs.vifm.enable = true;
}
