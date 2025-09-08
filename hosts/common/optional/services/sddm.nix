{ ... }:
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    autoNumlock = true;
    # theme = "${import (map lib.custom.relativeToRoot [
    #   "pkgs/sddm-elegant.nix"
    # ]) { inherit pkgs; }}";
  };
}
