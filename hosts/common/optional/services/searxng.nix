{config, ... }:
{
  services.searx = {
    enable = true;
    redisCreateLocally = true;
    settings.server = {
      bind_address = "::1";
      port = 8080;
      base_url = "https://localhost:8080";
      secret_key = "cat ${config.sops.secrets.searx-secret.path}"; # check if it actually sets the pass ... yes it does 2025-07-25 03:03:01,168 ERROR:searx.webapp: server.secret_key is not changed. Please use something else instead of ultrasecretkey.oh wait maybe it sets it as a literal string of the command
    };
  };
}
