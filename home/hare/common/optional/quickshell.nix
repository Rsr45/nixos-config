{ ... }:
{
  programs.quickshell = {
    enable = true;
    systemd.enable = false;
  };
  xdg.configFile = {
    "quickshell" = {
      source = ./quickshell;
      recursive = true;
    };
  };
}
