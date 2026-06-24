{ lib, config, ... }:
let
  cfg = config.modules.security.memoryAllocator;
in
{
  options.modules.security.memoryAllocator = {
    enable = lib.mkEnableOption "memory allocator configuration";

    provider = lib.mkOption {
      type = lib.types.enum [
        "scudo"
        "graphene-hardened"
      ];
      default = "scudo";
      example = "graphene-hardened";
      description = ''
        Memory allocator implementation to use.
      '';
    };
  };

  config = lib.mkIf cfg.enable {

    environment.memoryAllocator.provider = cfg.provider;

    environment.variables = lib.mkMerge [
      (lib.mkIf (cfg.provider == "scudo") {
        SCUDO_OPTIONS = "zero_contents=true";
      })
    ];

  };
}
