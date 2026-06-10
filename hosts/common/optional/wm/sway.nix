{pkgs, ...}: {
  programs.sway = {
    enable = true;
    xwayland.enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      sway-contrib.grimshot
      i3status-rust
    ];
  };
}
