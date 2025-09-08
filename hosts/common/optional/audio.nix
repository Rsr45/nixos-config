{ pkgs, ... }:
{

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    wireplumber.enable = true;
    # jack.enable = true;
    # media-session.enable = true;
  };

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      playerctl
      ;
  };
}
