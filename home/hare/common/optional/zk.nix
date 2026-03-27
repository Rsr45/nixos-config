{ config, ... }:
{
  programs.zk = {
    enable = true;
    settings = {
      notebook = {
        dir = "${config.home.homeDirectory}/Personal/Vaults/Personal/05_Fleeting";
      };
      note = {
        language = "en";
        default-title = "Untitled";
        filename = "{{id}}-{{slug title}}";
        extension = "md";
        template = "default.md";
        id-charset = "alphanum";
        id-length = 4;
        id-case = "lower";
      };
      extra = {
        author = "Mickaël";
      };
    };
  };
}
