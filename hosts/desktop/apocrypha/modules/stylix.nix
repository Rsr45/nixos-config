{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [inputs.stylix.homeManagerModules.stylix];

  stylix = {
    enable = true;
    autoEnable = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/mountain.yaml";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
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
      sizes = {
        desktop = 12;
        popups = 12;
        applications = 12;
        terminal = 12;
      };
    };

    targets = {
      # chromium.enable = true;
      gtk.enable = true;
      qt.enable = true;
      hyprland.enable = true;
      floorp = {
        enable = true;
        colorTheme.enable = true;
        profileNames = ["rsr"];
      };
      wezterm.enable = true;
      kitty.enable = true;
      wofi.enable = true;
      fuzzel.enable = true;
      dunst.enable = true;
      nixcord.enable = true;
      zed.enable = true;
      nvf.enable = true;
      btop.enable = true;
      mpv.enable = true;
      nushell.enable = true;
      spicetify.enable = true;
      tmux.enable = true;
      gitui.enable = true;
      waybar.enable = true;
    };
  };
}
