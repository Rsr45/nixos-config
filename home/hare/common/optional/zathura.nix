{ ... }:
{
  programs.zathura = {
    enable = true;
    extraConfig = ''
      include colors
      set font "monospace normal 12"
    '';
  };
}
