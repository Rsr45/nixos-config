{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  services.flatpak.packages = [
    "com.obsproject.Studio"
    "app.grayjay.Grayjay"
    # got to make sure updates are independent from my sproutic nix updates
    "chat.simplex.simplex"
    "com.brave.Browser"
    "org.mozilla.firefox"
    # Discord use one of them
    "dev.vencord.Vesktop"
    "org.equicord.equibop"
    "moe.kopuz.kopuz"
    rec {
      appId = "com.msob7y.namida";
      sha256 = "0q18cxwxy9p258ad9ybvsyi574zg4c1xbgwfpw177n596hhm5m4j";
      bundle = "${pkgs.fetchurl {
        url = "https://github.com/namidaco/namida-snapshots/releases/download/8.2.0-beta%2B261014207/Namida-x86_64-8.2.0-beta.flatpak";
        inherit sha256;
      }}";
    }
  ];

  services.flatpak.update.auto = {
    enable = true;
    onCalendar = "weekly"; # Default value
  };
}
