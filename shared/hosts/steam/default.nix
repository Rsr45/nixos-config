#FIX: put them into hosts/common/ as it makes more sense use shared for shit i do not want in my main config eg binaries user files etc see bios/ for actual usage
{
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.overlays = [inputs.millennium.overlays.default];

  programs = {
    steam = {
      enable = true;
      package = pkgs.millennium-steam;
      # package = pkgs.steam.override {
      #   extraPkgs =
      #     pkgs: with pkgs; [
      #       libXcursor
      #       libXi
      #       libXinerama
      #       libXScrnSaver
      #       libpng
      #       libpulseaudio
      #       libvorbis
      #       stdenv.cc.cc.lib
      #       libkrb5
      #       keyutils
      #     ];
      # };
      remotePlay = {
        openFirewall = true; # Open ports in the firewall for Steam Remote Play
      };
      dedicatedServer = {
        openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      };
      localNetworkGameTransfers = {
        openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      };
      protontricks.enable = true;
      gamescopeSession = {
        enable = true;
        args = [
          "-r 144"
          "-S stretch"
        ];
      };
    };
    gamemode = {
      enable = true;
    };
    gamescope = {
      enable = true;
      # capSysNice = true;
    };
  };

  environment.systemPackages = with pkgs; [
    wineWow64Packages.staging
    winetricks
    # protontricks
    protonup-qt
    mangohud
    steamcmd
  ];
}
