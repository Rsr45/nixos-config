{ pkgs, ... }:
{
  home.packages = with pkgs; [
    matugen
    pywalfox-native
  ];
  xdg.configFile = {
    "matugen/templates" = {
      source = ./templates;
      recursive = true;
    };
    "gtk-3.0/gtk.css".text =
      "@import url('${pkgs.adw-gtk3}/share/themes/adw-gtk3-dark/gtk-3.0/gtk.css');\n@import 'matugen.css';";
    "gtk-4.0/gtk.css".text =
      "@import url('${pkgs.adw-gtk3}/share/themes/adw-gtk3-dark/gtk-4.0/gtk.css');\n@import 'matugen.css';";
    # "Kvantum/kvantum.kvconfig".text = "[General]\ntheme=matugen";
    # "Kvantum/matugen".source = ../lib/matugen;
    "qt5ct/qt5ct.conf".text =
      "[Appearance]\ncolor_scheme_path=/home/hare/.config/qt5ct/colors/matugen.conf\ncustom_palette=true\nicon_theme=Papirus-Dark";
    "qt6ct/qt6ct.conf".text =
      "[Appearance]\ncolor_scheme_path=/home/hare/.config/qt6ct/colors/matugen.conf\ncustom_palette=true\nicon_theme=Papirus-Dark";
    # "qt5ct/qt5ct.conf".text =
    #   "color_scheme_path=~/.local/share/color-schemes/Matugen.colors\ncustom_palette=true\nicon_theme=breeze\nstyle=Breeze";
    # "qt6ct/qt6ct.conf".text =
    #   "color_scheme_path=~/.local/share/color-schemes/Matugen.colors\ncustom_palette=true\nicon_theme=breeze\nstyle=Breeze";
  };
}
