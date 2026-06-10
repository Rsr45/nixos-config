{config, ...}: ''
  /* searxng */

  @-moz-document domain("localhost") {
      :root {
          --uc-seamless-bg: #${config.lib.stylix.colors.base01} !important;
          --yt-spec-base-background: #${config.lib.stylix.colors.base00} !important;
      }

      html,
      html[dark],
      html[light],
      body {
          background-color: var(--uc-seamless-bg) !important;
          color: var(--uc-text) !important;
          border-radius: 0px !important;
      }

      #search,
      #results,
      #search_header,
      #main_results,
      footer {
          background-color: var(--uc-seamless-bg) !important;
          color: var(--uc-text) !important;
          border-radius: 0px !important;
      }

      #q,
      #clear_search,
      #send_search {
          background-color: var(--yt-spec-base-background) !important;
      }
  }

  /* end searxng */
''
