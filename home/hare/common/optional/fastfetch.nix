{...}: {
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        padding = {
          right = 2;
        };
      };
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
        "terminalfont"
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
