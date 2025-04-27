{
  config,
  pkgs,
  ...
}: {
  gtk = {
    enable = true;
    # iconTheme = {
    #   package = pkgs.papirus-icon-theme;
    #   name = "Papirus-Dark";
    # };
    # theme = {
    #   package = pkgs.adw-gtk3;
    #   name = "adw-gtk3-dark";
    # };
    gtk3 = {
      bookmarks = [
        "file://${config.home.homeDirectory}/Documents"
        "file://${config.home.homeDirectory}/Downloads"
        "file://${config.home.homeDirectory}/Music"
        "file://${config.home.homeDirectory}/Pictures"
        "file://${config.home.homeDirectory}/Videos"
        "file://${config.home.homeDirectory}/Games"
        "file://${config.home.homeDirectory}/Projects"
        "file://${config.home.homeDirectory}/Dev"
      ];
      # extraConfig = {
      #   gtk-application-prefer-dark-theme = 1;
      # };
    };
    # gtk4 = {
    #   extraConfig = {
    #     gtk-application-prefer-dark-theme = 1;
    #   };
    # };
  };
  # dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  # xdg.configFile = {
  # "gtk-3.0/gtk.css".text = "@import url('${pkgs.adw-gtk3}/share/themes/adw-gtk3-dark/gtk-3.0/gtk.css');\n@import 'gtk-gruvbox.css';";
  # "gtk-4.0/gtk.css".text = "@import url('${pkgs.adw-gtk3}/share/themes/adw-gtk3-dark/gtk-4.0/gtk.css');\n@import 'gtk-gruvbox.css';";
  # "gtk-3.0/gtk.css".text = "@import 'gtk-gruvbox.css';";
  # "gtk-4.0/gtk.css".text = "@import 'gtk-gruvbox.css';";
  # "gtk-3.0/gtk-gruvbox.css" = {
  #   source = ./gtk-gruvbox.css;
  # };
  # "gtk-4.0/gtk-gruvbox.css" = {
  #   source = ./gtk-gruvbox.css;
  # };
  # };
}
