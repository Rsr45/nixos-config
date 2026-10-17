{config, ...}: {
  services.searx = {
    enable = true;
    # redisCreateLocally = true;
    settings = {
      server = {
        bind_address = "127.0.0.1";
        port = 8080;
        # base_url = "http://localhost:8080/location";
        secret_key = "cat ${config.sops.secrets.searx-secret.path}"; # check if it actually sets the pass ... yes it does 2025-07-25 03:03:01,168 ERROR:searx.webapp: server.secret_key is not changed. Please use something else instead of ultrasecretkey.oh wait maybe it sets it as a literal string of the command
        # image_proxy = false;
        # limiter = false;
        # public_instance = false;
      };

      use_default_settings = true;

      general = {
        enable_metrics = false;
        donation_url = false;
        privacypolicy_url = false;
      };

      default_doi_resolver = "sci-hub.ru";

      # enabled_plugins = [
      #   "Hash plugin"
      #   "Search on category select"
      #   "Tracker URL remover"
      #   "Hostname replace"
      #   "Unit converter plugin"
      #   "Basic Calculator"
      #   "Open Access DOI rewrite"
      # ];

      plugins = {
        "searx.plugins.calculator.SXNGPlugin" = {
          active = true;
        };
        "searx.plugins.infinite_scroll.SXNGPlugin" = {
          active = false;
        };
        "searx.plugins.hash_plugin.SXNGPlugin" = {
          active = true;
        };
        "searx.plugins.self_info.SXNGPlugin" = {
          active = true;
        };
        "searx.plugins.unit_converter.SXNGPlugin" = {
          active = true;
        };
        "searx.plugins.ahmia_filter.SXNGPlugin" = {
          active = true;
        };
        "searx.plugins.hostnames.SXNGPlugin" = {
          active = true;
        };
        "searx.plugins.time_zone.SXNGPlugin" = {
          active = true;
        };
        "searx.plugins.oa_doi_rewrite.SXNGPlugin" = {
          active = true;
        };
        "searx.plugins.tor_check.SXNGPlugin" = {
          active = false;
        };
        "searx.plugins.tracker_url_remover.SXNGPlugin" = {
          active = true;
        };
      };

      ui = {
        center_alignment = true;
      };

      search = {
        safe_search = 1;

        formats = [
          "html"
          "json"
          "rss"
        ];
      };

      engines = [
        {
          name = "bing";
          disabled = false;
        }
        {
          name = "google";
          disabled = false;
        }
        {
          name = "brave";
          disabled = false;
        }
        {
          name = "duckduckgo";
          disabled = false;
        }
        {
          name = "startpage";
          disabled = false;
        }
        {
          name = "mojeek";
          disabled = false;
        }
      ];
    };
  };
}
