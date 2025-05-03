{ ... }:
{
  programs.tmux = {
    enable = true;
    clock24 = true;
    mouse = true;
    baseIndex = 1;
    keyMode = "vi";
    prefix = "C-x";
    shortcut = "x";
    terminal = "screen-256color";
  };
}
