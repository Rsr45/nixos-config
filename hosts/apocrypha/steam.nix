{pkgs, ...}: {
  programs = {
    steam = {
      enable = true;
      package = pkgs.steam.override {
        extraPkgs = pkgs:
          with pkgs; [
            xorg.libXcursor
            xorg.libXi
            xorg.libXinerama
            xorg.libXScrnSaver
            libpng
            libpulseaudio
            libvorbis
            stdenv.cc.cc.lib
            libkrb5
            keyutils
          ];
      };
      remotePlay = {
        openFirewall = true; # Open ports in the firewall for Steam Remote Play
      };
      dedicatedServer = {
        openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      };
      localNetworkGameTransfers = {
        openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      };
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
      capSysNice = true;
    };
  };
}
