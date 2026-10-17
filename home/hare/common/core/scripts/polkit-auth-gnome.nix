{pkgs, ...}: {
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "polkit-auth-gnome";
      runtimeInputs = with pkgs; [
        polkit_gnome
      ];
      bashOptions = [
        "errexit"
        "nounset"
        "pipefail"
      ];
      text = ''
        ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &
      '';
    })
  ];
}
