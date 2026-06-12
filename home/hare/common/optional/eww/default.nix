{ ... }:
{
  # FIXME:
  #   Failed assertions:
  # - hare profile: The option definition `programs.eww.configDir' in `/nix/store/gwxngisnvfgy954qyc7wfpw10wg762gg-source/home/hare/common/optional/eww' no longer has any effect; please remove it.
  # programs.eww.configDir is now deprecated, please use programs.eww.yuckConfig and programs.eww.scssConfig instead.
  programs.eww = {
    enable = true;
    configDir = ./conf;
  };
}
