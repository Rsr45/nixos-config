{ pkgs, config, ... }:
{
  services = {
    nextcloud = {
      enable = true;
      package = pkgs.nextcloud31;
      hostName = "localhost";
      configureRedis = true;
      database.createLocally = true;
      config = {
        adminuser = "admin";
        adminpassFile = "${config.sops.secrets.nextcloud-admin.path}";
        dbtype = "pgsql";
        # dbname = "nextcloud";
        # dbuser = "nextcloud";
      };
      settings = {
        default_phone_region = "TR";
        # redis = {
        #   host = "/run/redis/redis.sock";
        #   port = 0;
        #   dbindex = 0;
        #   password = "secret";
        #   timeout = 1.5;
        # };
      };
      extraApps = {
        inherit (config.services.nextcloud.package.packages.apps)
          news
          contacts
          calendar
          tasks
          ;
      };
      extraAppsEnable = true;
    };
    postgresql = {
      enable = true;
      ensureDatabases = [ "nextcloud" ];
      ensureUsers = [
        {
          name = "nextcloud";
          ensureDBOwnership = true;
        }
      ];
    };
    # postgresqlBackup = {
    # # optional backup for postgresql db
    #   enable = true;
    #   location = "/data/backup/nextclouddb";
    #   databases = [ "nextcloud" ];
    #   # time to start backup in systemd.time format
    #   startAt = "*-*-* 23:15:00";
    # };
  };
}
