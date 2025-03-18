{...}: {
  services = {
    mpd = {
      enable = true;
      extraConfig = ''
        audio_output {
        type "pipewire"
        name "MPD Output"
        }
      '';

      network.listenAddress = "any"; # if you want to allow non-localhost connections
    };
    mpd-discord-rpc.enable = true;
    mpd-mpris = {
      enable = true;
      mpd.useLocal = true;
    };
  };
}
