{...}: {
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        padding = {
          right = 2;
        };
      };
      # display = {
      # size = {
      # binaryPrefix = "si";
      # };
      # color = "blue";
      # separator = "  ";
      # };
      modules = [
        "Title"
        "Separator"
        "OS"
        "Kernel"
        "Bios"
        "Bootmgr"
        "Separator"
        "DE"
        "WM"
        "Terminal"
        "Shell"
        "Editor"
        "Font"
        "Separator"
        "Board"
        "CPU"
        "GPU"
        "Display"
        "Monitor"
        "Separator"
        "DateTime"
        "Uptime"
        "player"
        "media"
        "Colors"
      ];
    };
  };
}
