{ pkgs, ... }:
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    autoNumlock = true;
    theme = "${import ./pkgs/commonality.nix { inherit pkgs; }}";
  };
}
