{ pkgs, ... }:
{
  services.xserver.windowManager.awesome = {
    enable = true;
    luaModules = with pkgs.luaPackages; [
      vicious
      luarocks
      luadbi-mysql
    ];
  };
  environment.systemPackages = with pkgs; [
    fastcompmgr
    picom
  ];
}
