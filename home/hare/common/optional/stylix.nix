{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [ inputs.stylix.homeModules.stylix ];

  stylix = {
    enable = true;
    autoEnable = false;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-medium.yaml";
    polarity = "dark";
    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };

    fonts = {
      serif = {
        package = pkgs.geist-font;
        name = "Geist";
      };

      sansSerif = {
        package = pkgs.geist-font;
        name = "Geist";
      };

      monospace = {
        package = pkgs.iosevka;
        name = "Iosevka";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        desktop = 12;
        popups = 12;
        applications = 12;
        terminal = 12;
      };
    };

    cursor = {
      package = pkgs.kdePackages.breeze;
      name = "breeze_cursors";
      size = 24;
    };

    targets = {
      fontconfig.enable = true;
      font-packages.enable = true;
      starship.enable = true;
      fish.enable = true;
      nushell.enable = true;
      fzf.enable = true;
      bat.enable = true;
      feh.enable = true;
      yazi.enable = true;
      kitty.enable = true;
      wezterm.enable = true;
      alacritty.enable = true;
      foot.enable = true;
      tmux.enable = true;
      helix.enable = true;
      nixvim = {
        enable = true;
        plugin = "mini.base16";
      };
      nvf = {
        enable = true;
        plugin = "mini-base16";
      };
      neovide.enable = true;
      zed.enable = true;
      swaync.enable = true;
      sway.enable = true;
      dunst.enable = true;
      mpv.enable = true;
      sioyek.enable = true;
      qutebrowser.enable = true;
      zen-browser.enable = true;
      zen-browser.profileNames = [
        "default"
      ];
      nixcord.enable = true;
      spicetify.enable = true;
      obsidian = {
        enable = true;
        vaultNames = [ "nix-roam" ];
      };
      blender.enable = true;
      bemenu.enable = true;
      bemenu.alternate = true;
      vicinae.enable = true;
      noctalia-shell.enable = true;
      gtk = {
        enable = true;
        extraCss = ''
          // Remove rounded corners
          window.background { border-radius: 0; }
        '';
      };
      qt = {
        enable = true;
        standardDialogs = "xdgdesktopportal";
      };
      # hyprland.enable = true;
      hyprlock.enable = true;
      kde.enable = true;
      xresources.enable = true;
      # waybar.enable = false;
      # floorp = {
      #   enable = false;
      # #   colorTheme.enable = true;
      # #   profileNames = [ "rsr" ];
      # };
    };
  };

  home.file.".cache/wal/colors-wal.json".text =
    import (lib.custom.relativeToRoot "shared/wallust/colorschemes/stylix.nix")
      { inherit config; };

  xdg = {
    configFile = {
      "wallust/colorschemes/stylix.json".text =
        import (lib.custom.relativeToRoot "shared/wallust/colorschemes/stylix.nix")
          { inherit config; };

      "awesome/themes/custom/stylix.lua".text =
        import (lib.custom.relativeToRoot "shared/awesome/themes/stylix.nix")
          { inherit config; };

      "wallust/colorschemes/stylix-wal.json".text =
        import (lib.custom.relativeToRoot "shared/wallust/colorschemes/stylix.nix")
          { inherit config; };
    };
  };
}
