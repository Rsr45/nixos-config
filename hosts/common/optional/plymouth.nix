{ lib, pkgs, ... }:
{
  environment.systemPackages = [ pkgs.adi1090x-plymouth-themes ];
  boot = {
    kernelParams = [
      "quiet" # shut up kernel output prior to prompts
    ];
    plymouth = {
      enable = true;
      theme = lib.mkForce "red_loader";
      themePackages = [
        (pkgs.adi1090x-plymouth-themes.override { selected_themes = [ "red_loader" ]; })
      ];
    };
    consoleLogLevel = 0;
  };
}
