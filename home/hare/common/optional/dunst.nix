{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dunst
  ];

  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 300;
        height = 300;
        offset = "30x30";
        origin = "top-right";
        corner_radius = "0";
        gap_size = "8";
        frame_width = "2";
        font = "Geist Mono 11";
      };
    };
  };
}
