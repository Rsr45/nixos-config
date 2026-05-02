{ ... }:
{
  programs.google-chrome = {
    enable = true;
    commandLineArgs = [
      "--component-updater=disable-pings"
      "--disable-breakpad"
      "--disable-crash-reporter"
      "--no-default-browser-check"
      "--no-pings"
      "--js-flags=jitless"
      "--disable-optimizing-compilers"
      "--disable-webgl"
      "--disable-3d-apis"
      "--webrtc-ip-handling-policy=disable_non_proxied_udp"
      "--incognito"
      "--site-per-process"
      "--extension-content-verification=enforce_strict"
      "--extensions-install-verification=enforce_strict"
      ## Optional
      "--use-fake-device-for-media-stream"
      "--disable-reading-from-canvas"
      "--disable-extensions"
      "--disable-remote-fonts"
      "--disable-gpu"
    ];

    # extensions = [
    #   { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
    #   { id = "hfjbmagddngcpeloejdejnfgbamkjaeg"; } # vimiumc
    # ];

  };
}
