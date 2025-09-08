      userChrome = ''
        * {
          font-family: "${config.stylix.fonts.sansSerif.name}" !important;
        }

        :root {
          --bg: #${config.lib.stylix.colors.base00};
          --fg: #${config.lib.stylix.colors.base05};
          --surface: #${config.lib.stylix.colors.base01};
          --subtle: #${config.lib.stylix.colors.base04};
          --border: #${config.lib.stylix.colors.base09};
          --accent: #${config.lib.stylix.colors.base09};

          --toolbar-bgcolor: var(--bg) !important;
          --toolbarbutton-icon-fill: var(--fg) !important;

          --system-color-accent: var(--accent) !important;
          --system-color-accent-hover: var(--accent) !important;
          --system-color-accent-active: var(--accent) !important;

          --arrowpanel-background: var(--bg) !important;
          --arrowpanel-color: var(--fg) !important;
          --arrowpanel-dimmed: var(--bg) !important;
          --arrowpanel-border-color: var(--border) !important;

          --urlbar-box-bgcolor: var(--bg) !important;
          --urlbar-box-text-color: var(--fg) !important;

          --checkbox-checked-bgcolor: var(--accent) !important;
          --checkbox-checked-hover-bgcolor: var(--accent) !important;

          --button-primary-bgcolor: var(--accent) !important;
          --button-primary-hover-bgcolor: var(--accent) !important;
          --button-primary-active-bgcolor: var(--accent) !important;
          --button-primary-color: var(--bg) !important;

          --in-content-page-background: var(--bg) !important;

          --in-content-button-background: var(--bg) !important;
          --in-content-button-background-hover: var(--bg) !important;
          --in-content-button-background-active: var(--bg) !important;
          --in-content-button-text-color: var(--fg) !important;

          --in-content-primary-button-background: var(--accent) !important;
          --in-content-primary-button-background-hover: var(--accent) !important;
          --in-content-primary-button-text-color: var(--bg) !important;

          --focus-outline-color: var(--accent) !important;

          --lwt-text-color: var(--fg) !important;
          --tab-loading-fill: var(--accent) !important;
        }

        #navigator-toolbox {
          background: var(--bg) !important;
        }

        tab {
          color: var(--fg) !important;
        }

        .toolbarbutton-1 {
          color: var(--fg) !important;
        }

        #urlbar-background {
          background: var(--bg) !important;
          border-color: var(--border) !important;
          border: unset !important;
          box-shadow: unset !important;
        }

        #menubar-items {
          color: var(--fg) !important;
        }

        menubar > menu[open] {
          border-bottom-color: var(--accent) !important;
        }

        .urlbarView {
          border: 0px solid 0px !important;
          border-radius: 0 0 0px 0px;
        }

        .urlbarView-row[selected] {
          background-color: var(--accent) !important;
          color: black !important;
        }

        .urlbarView-row[source="bookmarks"] > .urlbarView-row-inner > .urlbarView-no-wrap > .urlbarView-favicon, #urlbar-engine-one-off-item-bookmarks {
          fill: var(--accent) !important;
        }

        .urlbarView-row-inner:not(:selected) .urlbarView-action {
          color: var(--accent) !important;
        }

        .urlbarView-row-inner:selected .urlbarView-action {
          color: var(--bg) !important;
        }

        .searchbar-engine-one-off-item[selected] {
          background-color: var(--accent) !important;
        }

        html|button[autofocus], html|button[type="submit"], xul|button[default], button.primary {
          background-color: var(--accent) !important;
        }

        menupopup {
          --panel-background: var(--bg) !important;
          --panel-color: var(--fg) !important;
          font-family: "${config.stylix.fonts.sansSerif.name}" !important;
        }

        menuitem {
          color: var(--fg) !important;
        }

        #star-button[starred] {
          fill: var(--accent) !important;
        }

        .toolbarbutton-badge {
          background-color: var(--bg) !important;
          color: var(--fg) !important;
        }

        #downloads-button[attention="success"] > .toolbarbutton-badge-stack > #downloads-indicator-anchor > #downloads-indicator-icon,
        #downloads-button[attention="success"] > .toolbarbutton-badge-stack > #downloads-indicator-start-box > #downloads-indicator-start-image,
        #downloads-indicator-finish-image {
          fill: var(--accent) !important;
          stroke: var(--accent) !important;
        }

        #downloads-indicator-progress-inner {
          background: conic-gradient(var(--accent) var(--download-progress-pcent), transparent var(--download-progress-pcent)) !important;
        }

        #urlbar .search-panel-one-offs-header-label {
          color: var(--fg) !important;
          opacity: 1.0 !important;
        }

        #commonDialog {
          background: var(--bg) !important;
        }

        .downloadProgress::-moz-progress-bar {
          background-color: var(--accent) !important;
        }
      '';

