{
  pkgs,
  config,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "hare";
  home.homeDirectory = "/home/hare";

  imports = [
    ./modules/stylix.nix
    ./modules/gtk.nix
    ./modules/font.nix
    ./modules/hyprland.nix
    ./modules/hyprlock.nix
    # ./modules/matugen.nix
    ./modules/spotify.nix
    ./modules/mpd.nix
    ./modules/nixcord.nix
    ./modules/terminals/default.nix
    ./modules/widgets/default.nix
    ./modules/browsers/default.nix
    ./modules/editors/default.nix
    ./modules/shell/default.nix
    ./modules/cli/default.nix
    ./modules/default.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    extraConfig = {
      XDG_DEV_DIR = "${config.home.homeDirectory}/Dev";
      XDG_PROJECTS_DIR = "${config.home.homeDirectory}/Projects";
      XDG_GAMES_DIR = "${config.home.homeDirectory}/Games";
      XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
      XDG_WALLPAPERS_DIR = "${config.xdg.userDirs.pictures}/Wallpapers";
      XDG_YOUTUBEMUSIC_DIR = "${config.xdg.userDirs.music}/Youtube";
      XDG_YOUTUBE_DIR = "${config.xdg.userDirs.videos}/Youtube";
    };
  };
  # xdg = {
  #   mimeApps = {
  #     enable = true;
  #     defaultApplications = {
  #       "image/jpeg" = "feh.desktop";
  #       "image/png" = "feh.desktop";
  #       "image/gif" = "mpv.desktop";
  #       "image/webp" = "feh.desktop";
  #       "application/pdf" = "floorp.desktop";
  #       "text/html" = "floorp.desktop";
  #       "x-scheme-handler/http" = "floorp.desktop";
  #       "x-scheme-handler/https" = "floorp.desktop";
  #       "x-scheme-handler/about" = "floorp.desktop";
  #       "x-scheme-handler/unknown" = "floorp.desktop";
  #       "inode/directory" = "nemo.desktop";
  #       "application/x-gnome-saved-search" = "nemo.desktop";
  #       "text/plain" = "neovide.desktop";
  #       "application/zip" = "xarchiver.desktop";
  #       "application/vnd.rar" = "xarchiver.desktop";
  #       "application/x-7z-compressed" = "xarchiver.desktop";
  #       "application/x-tar" = "xarchiver.desktop";
  #       "application/vnd.microsoft.portable-executable" = "wine.desktop";
  #     };
  #   };
  # };

  dconf = {
    enable = true;
    settings = {
      "org/cinnamon/desktop/applications/terminal" = {
        exec = "kitty";
        # exec-arg = ""; # argument
      };
    };
  };

  programs.gitui.enable = true;
  programs.btop.enable = true;
  programs.mpv.enable = true;

  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 300;
        height = 300;
        offset = "30x30";
        origin = "bottom-right";
        corner_radius = "7";
        gap_size = "8";
      };
    };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    nsxiv
    #   # # Fonts
    #   font-awesome
    #   ibm-plex
    #   nerd-fonts.blex-mono

    #   # # You can also create simple shell scripts directly inside your
    #   # # configuration. For example, this adds a command 'my-hello' to your
    #   # # environment:
    #   # (pkgs.writeShellScriptBin "my-hello" ''
    #   #   echo "Hello, ${config.home.username}!"
    #   # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/fangyuan/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vi";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
