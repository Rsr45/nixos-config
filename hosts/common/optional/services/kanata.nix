{ ... }:
{
  services.kanata = {
    enable = true;
    keyboards = {
      default = {
        configFile = ./ka-default.kbd;
      };
    };
  };
}
