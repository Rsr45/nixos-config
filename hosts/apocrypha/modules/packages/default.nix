{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ffmpeg
    ffmpegthumbnailer
    xclip
    wl-clipboard
    ps3iso-utils
    ps3-disc-dumper
    playerctl
    dunst
    libnotify
    pwvucontrol
    grim # Screenshot
    slurp # Screenshot
    osu-lazer-bin
    anyrun
    quodlibet-full
    pcsx2
    waylogout
    xwayland-satellite
    swww
    ueberzugpp
    gimp3
  ];
}
