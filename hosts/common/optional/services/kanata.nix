{ ... }:
{
  services.kanata = {
    enable = true;
    keyboards = {
      default = {
        configFile = ./ka-secondcoming.kbd;
      };
    };
  };
}
