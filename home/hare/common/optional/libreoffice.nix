{ pkgs, ... }:
{
  home.packages = with pkgs; [
    libreoffice-qt-fresh
  ];

  home.sessionVariables = {
    SAL_USE_VCLPLUGIN = "kf5";
  };
}
