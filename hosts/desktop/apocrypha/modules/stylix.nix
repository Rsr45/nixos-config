{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [inputs.stylix.nixosModules.stylix];
  stylix.homeManagerIntegration.autoImport = true;
  stylix.homeManagerIntegration.followSystem = true;

  stylix = {
    enable = true;
    autoEnable = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };
    targets = {
      gtk.enable = true;
      qt.enable = true;
      chromium.enable = true;
    };
    fonts = {
      serif = {
        package = pkgs.ibm-plex;
        name = "IBM Plex Serif";
      };

      sansSerif = {
        package = pkgs.ibm-plex;
        name = "IBM Plex Sans";
      };

      monospace = {
        package = pkgs.nerd-fonts.blex-mono;
        name = "BlexMono Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      sizes.desktop = 12;
      sizes.popups = 12;
      sizes.applications = 12;
      sizes.terminal = 12;
    };
  };

  home-manager.users.hare = {
    stylix = {
      iconTheme = {
        enable = true;
        package = pkgs.papirus-icon-theme;
        dark = "Papirus-Dark";
        light = "Papirus-Light";
      };
      targets = {
        gtk.enable = true;
        qt.enable = true;
        wezterm.enable = true;
        kitty.enable = true;
        wofi.enable = true;
        fuzzel.enable = true;
        dunst.enable = true;
        nixcord.enable = true;
        zed.enable = true;
        btop.enable = true;
        mpv.enable = true;
        nushell.enable = true;
        spicetify.enable = true;
      };
    };
  };
}
