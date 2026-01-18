      userContent = ''
        @-moz-document regexp("^moz-extension://.*?/sidebar/sidebar.html") {

          :root {
            --bg: #${config.lib.stylix.colors.base00};
            --fg: #${config.lib.stylix.colors.base05};
            --surface: #${config.lib.stylix.colors.base01};
            --accent: #${config.lib.stylix.colors.base09};
          }

          #root.root {--scroll-progress-bg: #${config.lib.stylix.colors.base09}!important;}
          #root.root {--border: #${config.lib.stylix.colors.base09}!important;}
          #root.root {--windows-popup-window-border: #${config.lib.stylix.colors.base09}!important;}
          #root.root {--accent: #${config.lib.stylix.colors.base09}!important;}
          #root.root {--nav-btn-accent: #${config.lib.stylix.colors.base09}!important;}
          #root.root {--frame-el-overlay-selected-border: #${config.lib.stylix.colors.base09}!important;}
          #root.root {--toolbar-el-overlay-selected-border: #${config.lib.stylix.colors.base09}!important;}

          #root.root {--ctx-menu-fg: #${config.lib.stylix.colors.base05}!important;}
          #root.root {--active-el-fg: #${config.lib.stylix.colors.base05}!important;}
          #root.root {--ctx-menu-shadow: #${config.lib.stylix.colors.base05}!important;}
          #root.root {--popup-fg: #${config.lib.stylix.colors.base05}!important;}
          #root.root {--bookmarks-node-activated-fg: #${config.lib.stylix.colors.base05}!important;}
          #root.root {--tabs-activated-fg: #${config.lib.stylix.colors.base05}!important;}
          #root.root {--tabs-normal-fg: #${config.lib.stylix.colors.base05}!important;}
          #root.root {--nav-btn-fg: #${config.lib.stylix.colors.base05}!important;}
          #root.root {--frame-fg: #${config.lib.stylix.colors.base05}!important;}
          #root.root {--frame-el-fg: #${config.lib.stylix.colors.base05}!important;}
          #root.root {--toolbar-fg: #${config.lib.stylix.colors.base05}!important;}
          #root.root {--notification-fg: #${config.lib.stylix.colors.base05}!important;}

          #root.root {--frame-el-bg: #${config.lib.stylix.colors.base00}!important;}
          #root.root {--toolbar-bg: #${config.lib.stylix.colors.base00}!important;}
          #root.root {--tabs-normal-bg: #${config.lib.stylix.colors.base00}!important;}
          #root.root {--ctx-menu-separator: #${config.lib.stylix.colors.base00}!important;}
          #root.root {--frame-bg: #${config.lib.stylix.colors.base00}!important;}
          #root.root {--active-el-bg: #${config.lib.stylix.colors.base00}!important;}
          #root.root {--notification-bg: #${config.lib.stylix.colors.base00}!important;}
          #root.root {--popup-bg: #${config.lib.stylix.colors.base00}!important;}

          #root.root {--tabs-activated-bg: #${config.lib.stylix.colors.base01}!important;}
          #root.root {--ctx-menu-bg: #${config.lib.stylix.colors.base01}!important;}
          #root.root {--toolbar-el-overlay-active-bg: #${config.lib.stylix.colors.base01}!important;}
        }

        @-moz-document url-prefix("about:") {
          * {
            font-family: "${config.stylix.fonts.sansSerif.name}" !important;
          }

          html {
            background: #${config.lib.stylix.colors.base00};
          }

          :root {
            --bg: #${config.lib.stylix.colors.base00};
            --fg: #${config.lib.stylix.colors.base05};
            --surface: #${config.lib.stylix.colors.base01};
            --accent: #${config.lib.stylix.colors.base09};
            --border: #${config.lib.stylix.colors.base09};

            --in-content-page-background: var(--bg) !important;
            --in-content-page-color: var(--fg) !important;

            --in-content-text-color: var(--fg) !important;

            --in-content-box-background: var(--surface) !important;
            --in-content-box-info-background: var(--surface) !important;
            --in-content-box-border-color: var(--border) !important;

            --in-content-table-background: var(--surface) !important;

            --newtab-background-color: var(--bg) !important;
            --newtab-background-color-secondary: var(--surface) !important;
            --newtab-text-primary-color: var(--fg) !important;
            --newtab-primary-element-text-color: var(--bg) !important;
            --newtab-primary-action-background: var(--accent) !important;

            --brand-color-accent: var(--accent) !important;
            --color-accent-primary-hover: var(--accent) !important;
            --color-accent-primary-active: var(--accent) !important;

            --in-content-primary-button-background: var(--accent) !important;
            --in-content-primary-button-background-active: var(--accent) !important;
            --in-content-primary-button-background-hover: var(--accent) !important;
            --in-content-primary-button-text-color: var(--bg) !important;

            --checkbox-unchecked-bgcolor: var(--surface) !important;
            --checkbox-unchecked-hover-bgcolor: var(--surface) !important;

            --in-content-button-background: var(--surface) !important;
            --in-content-button-background-hover: var(--surface) !important;

            --card-shadow: transparent !important;
          }

          .search-wrapper .logo-and-wordmark .wordmark {
            fill: var(--fg) !important;
          }

          .checkbox-check[checked] {
            color: var(--bg) !important;
          }

          html|button[autofocus], html|button[type="submit"], xul|button[default], button.primary {
            background-color: var(--accent) !important;
          }

          panel {
            --panel-background: var(--surface) !important;
            --panel-color: var(--fg) !important;
          }

          panel-list {
            background: var(--surface) !important;
          }

          input[type="checkbox"]:enabled:checked,
          input[type="checkbox"]:enabled:checked:hover {
            background-color: var(--accent) !important;
          }

          #trackingProtectionShield {
            color: var(--accent) !important;
          }

          .dialogBox {
            background-color: var(--bg) !important;
          }

          dialog {
            background-color: var(--bg) !important;
            color: var(--fg) !important;
          }

          .privacy-detailedoption {
            background-color: var(--surface) !important;
          }

          .addon-detail-actions input[type="radio"]:not(:checked) {
            background-color: var(--bg) !important;
          }

          .theme-enable-button {
            background-color: var(--bg) !important;
          }

          .toggle-button {
            --toggle-background-color: var(--bg) !important;
            --toggle-background-color-hover: var(--bg) !important;
            --toggle-background-color-active: var(--bg) !important;
            --toggle-border-color: var(--fg) !important;
          }
        }
      '';

