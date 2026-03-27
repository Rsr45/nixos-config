{ pkgs, ... }:
{
  programs.bat = {
    enable = true;
    config = {
      # Git modifications and file header (but no grid)
      style = "changes,header";
      theme = "gruvbox-dark";
    };
    extraPackages = with pkgs.bat-extras; [
      batgrep
      batdiff
      batman
    ];
  };

  # Avoid [bat error]: The binary caches for the user-customized syntaxes and themes in
  # '/home/<user>/.cache/bat' are not compatible with this version of bat (0.25.0).
  # home.activation.batCacheRebuild = {
  #   after = [ "linkGeneration" ];
  #   before = [ ];
  #   data = ''
  #     ${pkgs.bat}/bin/bat cache --build
  #   '';
  # };

}
