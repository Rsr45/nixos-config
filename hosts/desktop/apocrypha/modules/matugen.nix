{pkgs, ...}: {
  xdg.configFile = {
    "matugen" = {
      source = ../config-dir/matugen-conf-dir;
      recursive = true;
    };
    # "gtk-3.0/gtk.css".text = "@import url('${pkgs.adw-gtk3}/share/themes/adw-gtk3-dark/gtk-3.0/gtk.css');\n@import 'colors.css';";
    # "gtk-4.0/gtk.css".text = "@import url('${pkgs.adw-gtk3}/share/themes/adw-gtk3-dark/gtk-4.0/gtk.css');\n@import 'colors.css';";
    # "Kvantum/kvantum.kvconfig".text = "[General]\ntheme=matugen";
    # "Kvantum/matugen".source = ../lib/matugen;
    # "qt5ct/qt5ct.conf".text = "[Appearance]\ncolor_scheme_path=/home/hare/.config/qt5ct/colors/matugen.conf\ncustom_palette=true";
    # "qt6ct/qt6ct.conf".text = "[Appearance]\ncolor_scheme_path=/home/hare/.config/qt6ct/colors/matugen.conf\ncustom_palette=true";
  };
}
