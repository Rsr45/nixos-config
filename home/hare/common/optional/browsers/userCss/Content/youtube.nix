{config, ...}: ''
  /* youtube */

  @-moz-document domain("youtube.com") {
      :root {
          --uc-seamless-bg: #${config.lib.stylix.colors.base01} !important;
          --yt-spec-base-background: #${config.lib.stylix.colors.base00} !important;
      }

      html,
      html[dark],
      body,
      ytd-app {
          background-color: var(--uc-seamless-bg) !important;
          color: var(--uc-text) !important;
          border-radius: 0px !important;
      }


      /*sidebar*/
      #background.ytd-masthead {
          background: var(--uc-seamless-bg) !important;
          /* filter: saturate(140%) !important; */
          /* backdrop-filter: blur(33px); */
      }

      #contentContainer {
          background: var(--uc-seamless-bg) !important;
          /* backdrop-filter: blur(33px); */
      }

      /* header*/
      #background.ytd-masthead {
          background: var(--uc-seamless-bg) !important;
          /* backdrop-filter: blur(50px); */
      }

      #header {
          background: var(--uc-seamless-bg) !important;
          /* backdrop-filter: blur(50px); */
      }

      #container.style-scope.ytd-masthead {
          background-color: var(--uc-seamless-bg) !important;
      }

      #frosted-glass.with-chipbar.ytd-app {
          height: 0px !important;
      }

      ytd-feed-filter-chip-bar-renderer {
          --ytd-rich-grid-chips-bar-top: 0px !important;
          top: 1 !important;
      }

      /*search bar*/
      .ytSearchboxComponentInputBoxDark,
      html[dark] .sbsb_a,
      .ytSearchboxComponentInputBox,
      ##.ytSearchboxComponentSearchButtonDark.ytSearchboxComponentSearchButton,
      .ytSearchboxComponentSearchButton {
          background-color: var(--yt-spec-base-background) !important;
          border: none !important;
          box-shadow: var(--yt-spec-base-background) 0px 1px 2px inset !important;
      }

      /*search results popup*/
      .ytSearchboxComponentSuggestionsContainer {
          background-color: rgba(0, 0, 0, 0.5) !important;
          /* @media (prefers-color-scheme: light) {background-color: rgba(100,100,100,0.1) !important;} */
      }

      /*notifications popup*/
      .ytd-multi-page-menu-renderer {
          /* @media -moz-pref("user.theme.0.default") {--uc-seamless-bg: rgba(1,1,1,0.1) !important;} */
          background-color: var(--uc-seamless-bg) !important;
      }

      .style-scope.ytd-popup-container {
          background-color: rgba(0, 0, 0, 0.2) !important;
          /* @media (prefers-color-scheme: light) {background-color: transparent !important;} */
          backdrop-filter: blur(35px);
      }

      /*video player context menu*/
      .ytp-popup {
          /* @media -moz-pref("user.theme.0.default") {--uc-seamless-bg: rgba(1,1,1,0.1) !important;} */
          background-color: var(--uc-seamless-bg) !important;
      }

      .ytp-popup.ytp-contextmenu {
          background-color: var(--uc-seamless-bg) !important;
          /* @media (prefers-color-scheme: light) {background-color: rgba(100,100,100,0) !important;} */
          backdrop-filter: blur(33px);
      }

      .ytp-panel-menu {
          padding: 8px !important;
      }

      .ytp-menuitem:hover {
          /* clip-path: xywh(0 0 100% 100% round 0.5em) !important; */
          /* background-color: rgba(40,40,50,0.5) !important; */
          /* @media (prefers-color-scheme: light) {background-color: rgba(0,0,0,0.3) !important;} */
      }

      .ytp-panel-menu,
      .ytp-panel-header {
          background-color: rgba(0, 0, 0, 0.5) !important;
          /* @media (prefers-color-scheme: light) {background-color: rgba(100,100,100,0.3) !important;} */
          backdrop-filter: blur(33px);
      }

      .ytp-popup.ytp-settings-menu {
          /* @media (prefers-color-scheme: light) {background-color: rgba(0,0,0,0.3) !important;} */
      }

      /*thumbnails*/
      .yt-spec-icon-badge-shape--style-overlay .yt-spec-icon-badge-shape__badge {
          border: 0px solid rgba(0, 0, 0, 0.8) !important;
      }

      .badge-style-type-live-now-alternate.ytd-badge-supported-renderer {
          background: rgba(92, 198, 223, 0.9) !important;
          color: var(--yt-spec-static-brand-white) !important;
      }

      /* extra */

      /* yt-early New To You chip */
      #chips {
          display: flex !important;
      }

      #chips>yt-chip-cloud-chip-renderer:nth-last-child(1) {
          order: 1 !important;
          margin-right: 12px !important;
      }

      #chips>yt-chip-cloud-chip-renderer:not(:nth-last-child(1)) {
          order: 2 !important;
      }

      #chips>yt-chip-cloud-chip-renderer:nth-child(1) {
          order: 1 !important;
      }

  }

  /* end YT */
''
