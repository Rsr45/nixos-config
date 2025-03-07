{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    mouse = true;
    keyMode = "vi";
    prefix = "C-x";
    shortcut = "x";
    terminal = "screen-256color";
  };
}
