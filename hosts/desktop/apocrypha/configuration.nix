{ pkgs, inputs, ... }:

{
    imports =
        [ # Include the results of the hardware scan.
            ./hardware-configuration.nix
            inputs.home-manager.nixosModules.home-manager
        ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    # boot.loader.grub.enable = true;
    # boot.loader.grub.device = "/dev/vda";
    # boot.loader.grub.useOSProber = true;

    networking.hostName = "apocrypha"; # Define hostname
    # networking.wireless.enable = true; # Enable wireless support via wpa_supplicant

    # Configure network proxy
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    networking.networkmanager.enable = true; # Enable networking

    time.timeZone = "Europe/Istanbul"; # Set time zone

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "tr_TR.UTF-8";
        LC_IDENTIFICATION = "tr_TR.UTF-8";
        LC_MEASUREMENT = "tr_TR.UTF-8";
        LC_MONETARY = "tr_TR.UTF-8";
        LC_NAME = "tr_TR.UTF-8";
        LC_NUMERIC = "tr_TR.UTF-8";
        LC_PAPER = "tr_TR.UTF-8";
        LC_TELEPHONE = "tr_TR.UTF-8";
        LC_TIME = "tr_TR.UTF-8";
    };

    # Configure keymap in X11
    services.xserver.xkb = {
        layout = "tr";
        variant = "";
    };

    # Configure console keymap
    console.keyMap = "trq";

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable Shell
    programs.fish.enable = true;
    # programs.nushell.enable = true;
    programs.zsh.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.hare = {
        isNormalUser = true;
        description = "Hare";
        extraGroups = [
            "networkmanager"
            "wheel"
            "libvirtd"
        ];
        #packages = with pkgs; [
        #  thunderbird
        #];
        shell = pkgs.zsh;
    };

    home-manager = {
        extraSpecialArgs = { inherit inputs; };
        backupFileExtension = "backup";
        users = {
            hare = import ./home.nix;
        };
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Enable flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    services.xserver = {
        enable = true; # Enable X11
        autorun = true; # Define if it should autostart
        videoDrivers = [ "amdgpu" ]; # Manually set drivers
    };

    hardware.graphics = {
        enable = true; # Enable Opengl
        enable32Bit = true; # Enable support for 32Bit
    };

    # # i3 Window Manager
    services.xserver.windowManager.i3.enable = true;

    # # Display Manager
    services.displayManager = {
        sddm.enable = true;
        # lightdm.enable = true;
    };

    # # Sway Window Manager
    # programs.sway = {
        # enable = true;
        # package = pkgs.swayfx;
    # };

    # # Hyprland Window Manager
    programs.hyprland = {
        enable = true;
    };
    # # Hint Electron apps to use Wayland
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    # # Enable Kitty Terminal [DEPRECATED]
    # programs.kitty.enable = true;

    xdg.portal = {
        enable = true;
        wlr.enable = true;
    };

    # # Polkit
    security.polkit.enable = true;
    systemd = {
        user.services.polkit-gnome-authentication-agent-1 = {
            description = "polkit-gnome-authentication-agent-1";
            wantedBy = [ "graphical-session.target" ];
            wants = [ "graphical-session.target" ];
            after = [ "graphical-session.target" ];
            serviceConfig = {
                Type = "simple";
                ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
                Restart = "on-failure";
                RestartSec = 1;
                TimeoutStopSec = 10;
            };
        };
    };

    # # File Explorer
    programs.thunar.enable = true;
    programs.thunar.plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
    ];
    services.gvfs.enable = true; # Mount, trash, and other functionalities
    services.tumbler.enable = true; # Thumbnail support for images

    # # Audio
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # jack.enable = true;

        # media-session.enable = true;
    };

    environment.systemPackages = with pkgs; [
        home-manager
        polkit # Polkit
        polkit_gnome # Polkit Agent
        ffmpegthumbnailer # Video files thumbnail
        libgcc
        gcc
        zig
        clang
        go
        wl-clipboard
        xclip
        #palemoon-bin
        floorp
        #librewolf
        tor
        pywal
        polybar
        swww
        papirus-icon-theme
        fastfetch
        # # Basic Utils
        binutils
        coreutils
        diffutils
        fd
        file
        findutils
        fzf
        gawk
        git
        glibc
        gnugrep
        gnumake
        gnused
        gnutar
        less
        procps
        ripgrep
        sharutils
        stow
        toybox
        util-linux
        xz
        # # Archive Managers and Compression
        p7zip
        peazip # Manager
        rar
        unrar
        unzip
        xarchiver # Manager
        zip
        # # File Explorer
        lf
        pcmanfm
        ranger
        superfile
        # # Terminal
        alacritty
        kitty
        tmux
        wezterm
        # # Editors
        # emacs
        # neovim
        vim
        # # VSCode
        vscodium
        (vscode-with-extensions.override {
            vscode = vscodium;
            vscodeExtensions = with vscode-extensions; [
                bbenoist.nix
                ms-python.python
                ms-azuretools.vscode-docker
                ms-vscode-remote.remote-ssh
            ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
                {
                    name = "remote-ssh-edit";
                    publisher = "ms-vscode-remote";
                    version = "0.47.2";
                    sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
                }
            ];
        })
        # # App Launchers and Widgets
        ags
        dmenu
        eww
        tofi
        rofi
        wofi
        # # Utils
        yt-dlp
        thefuck
        ffmpeg
        ps3iso-utils
        ps3-disc-dumper
        tldr
        bun
        dart-sass
        libnotify
        notify
        notify-client
        pwvucontrol
        grim
        slurp
        socat
        jq
        python3
        # # Apps
        vesktop
        feh
        mpv
        mpvc
        qbittorrent
        logmein-hamachi
        haguichi
        anydesk
        obsidian # Note
        keepassxc # Password Manager
        smassh
        typioca
        mapscii
        librewolf #Browser
        floorp # Browser
        tor # Browser
        motrix # Download Manager
        # # Language Server
        nil
        # # Wine
        wineWowPackages.staging
        winetricks
        protontricks
        # # Launchers and some utils
        heroic
        lutris
        mangohud
    ];

    # # Steam and Gamescope
    programs = {
        gamescope = {
            enable = true;
            capSysNice = true;
        };
        steam = {
            enable = true;
            remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
            dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
            localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
            gamescopeSession.enable = true;
            gamescopeSession.args = [ "-r 144" "-S stretch" ];
        };
        gamemode.enable = true;
    };

    hardware.xone.enable = true; # support for the xbox controller USB dongle

    fonts.packages = with pkgs; [
        (nerdfonts.override { fonts = [ "FiraCode" ]; })
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        liberation_ttf
    ];

    # stylix.enable = true;
    # stylix.autoEnable = true;
    # stylix.polarity = "dark";
    # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
    # stylix.image = ./wallhaven-d6y12l_3840x2160.png;

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    system.stateVersion = "24.05";
}
