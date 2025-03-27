{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [inputs.stylix.homeManagerModules.stylix];

  stylix = {
    enable = true;
    # autoEnable = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    override = {
      base01 = "#282828";
      base02 = "#3c3836";
      base03 = "#504945";
    };

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
        package = pkgs.cantarell-fonts;
        name = "Cantarell";
      };

      sansSerif = {
        package = pkgs.cantarell-fonts;
        name = "Cantarell";
      };

      monospace = {
        package = pkgs.nerd-fonts.fira-code;
        name = "FiraCode Nerd Font";
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
      gtk.enable = true;
      qt.enable = true;
      hyprland.enable = true;
      wezterm.enable = true;
      kitty.enable = true;
      ghostty.enable = true;
      wofi.enable = true;
      fuzzel.enable = true;
      dunst.enable = true;
      nixcord.enable = false;
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
