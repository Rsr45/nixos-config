{ inputs, ... }:
{
  imports = [ inputs.omnisearch.nixosModules.default ];

  documentation.nixos.options.warningsAreErrors = false;
  services.omnisearch = {
    enable = true;
    # configFile = ./omni-config.ini;
    settings = {
      server = {
        host = "0.0.0.0";
        port = 8087;
        domain = "http://localhost:8087";
      };
      # proxy = {
      #   proxy = lib.mkOption {
      #     type = lib.types.nullOr lib.types.str;
      #     default = null;
      #   };
      #   list_file = lib.mkOption {
      #     type = lib.types.nullOr lib.types.str;
      #     default = null;
      #   };
      #   max_retries = lib.mkOption {
      #     type = lib.types.int;
      #     default = 3;
      #   };
      #   randomize_username = lib.mkOption {
      #     type = lib.types.bool;
      #     default = true;
      #   };
      #   randomize_password = lib.mkOption {
      #     type = lib.types.bool;
      #     default = true;
      #   };
      # };
      # cache = {
      #   dir = lib.mkOption {
      #     type = lib.types.str;
      #     default = "/var/cache/omnisearch";
      #   };
      #   ttl_search = lib.mkOption {
      #     type = lib.types.int;
      #     default = 3600;
      #   };
      #   ttl_infobox = lib.mkOption {
      #     type = lib.types.int;
      #     default = 86400;
      #   };
      # };
    };
  };
}
