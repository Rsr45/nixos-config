# https://github.com/schizofox/schizofox/blob/main/flake/modules/common/firefox/userChrome.nix
{ config, ... }:
let
  font = "${config.stylix.fonts.sansSerif.name}";
  foreground = "${config.lib.stylix.colors.withHashtag.base05}";
  background = "${config.lib.stylix.colors.withHashtag.base01}";
  background-darker = "${config.lib.stylix.colors.withHashtag.base00}";
  primary = "${config.lib.stylix.colors.withHashtag.base0D}";
  border = "${config.lib.stylix.colors.withHashtag.base0D}";
  userChrome = ''
    * {
      font-family: "${font}" !important;
      border-radius: 0px !important;
      box-shadow: none !important;
    }

    :root {
      --toolbar-bgcolor: ${background} !important;
      --toolbarbutton-icon-fill: ${foreground} !important;

      --system-color-accent: ${primary} !important;
      --system-color-accent-hover: ${primary} !important;
      --system-color-accent-active: ${primary} !important;

      --arrowpanel-background: ${background} !important;
      --arrowpanel-color: ${foreground} !important;
      --arrowpanel-dimmed: ${background} !important;
      --arrowpanel-border-color: ${border} !important;

      --urlbar-box-bgcolor: ${background} !important;
      --urlbar-box-text-color: ${foreground} !important;

      --checkbox-checked-bgcolor: ${primary} !important;
      --checkbox-checked-hover-bgcolor: ${primary} !important;

      --button-primary-bgcolor: ${primary} !important;
      --button-primary-hover-bgcolor: ${primary} !important;
      --button-primary-active-bgcolor: ${primary} !important;
      --button-primary-color: ${background-darker} !important;

      --in-content-page-background: ${background-darker} !important;

      --in-content-button-background: ${background} !important;
      --in-content-button-background-hover: ${background} !important;
      --in-content-button-background-active: ${background} !important;
      --in-content-button-text-color: ${foreground} !important;

      --in-content-primary-button-background: ${primary} !important;
      --in-content-primary-button-background-hover: ${primary} !important;
      --in-content-primary-button-text-color: ${background-darker} !important;

      --focus-outline-color: ${primary} !important;

      --lwt-text-color: ${foreground} !important;
      --tab-loading-fill: ${primary} !important;
    }

    #navigator-toolbox {
      background: ${background-darker} !important;
      /*border-bottom: 1px solid ${border} !important;*/
    }

    #nav-bar {
      max-height: 28px !important;
      min-height: 28px !important;
      padding-top: 0 !important;
      padding-bottom: 0 !important;
    }

    tab {
      color: ${foreground} !important;
    }

    .toolbarbutton-1 {
      color: ${foreground} !important;
    }

    #urlbar-container {
      max-height: 26px !important;
      padding: 0 !important;
      margin: 0 !important;
    }

    #urlbar {
      color: ${foreground} !important;
      min-height: 26px !important;
      height: 26px !important;
      border: unset !important;
      box-shadow: unset !important;
    }

    #urlbar-background {
      background: ${background-darker} !important;
      border-color: ${border} !important;
      border: unset !important;
      box-shadow: unset !important;
    }

    #menubar-items {
      color: ${foreground} !important;
    }

    menubar > menu[open] {
      border-bottom-color: ${primary} !important;
    }

    .urlbarView-results {
      background-color: ${background} !important;
    }

    .urlbarView-row[selected] {
      background-color: ${primary} !important;
      color: black !important;
    }

    .urlbarView-row[source="bookmarks"] > .urlbarView-row-inner > .urlbarView-no-wrap > .urlbarView-favicon, #urlbar-engine-one-off-item-bookmarks {
      fill: ${primary} !important;
    }

    .urlbarView-row-inner:not(:selected) .urlbarView-action {
      color: ${primary} !important;
    }

    .urlbarView-row-inner:selected .urlbarView-action {
      color: ${background-darker} !important;
    }

    .searchbar-engine-one-off-item[selected] {
      background-color: ${primary} !important;
    }

    html|button[autofocus], html|button[type="submit"], xul|button[default], button.primary {
      background-color: ${primary} !important;
    }

    menupopup {
      --panel-background: ${background} !important;
      --panel-color: ${foreground} !important;
      font-family: "${font}" !important;
    }

    menuitem {
      color: ${foreground} !important;
    }

    #star-button[starred] {
      fill: ${primary} !important;
    }

    .toolbarbutton-badge {
      background-color: ${background-darker} !important;
      color: ${foreground} !important;
    }

    #downloads-button[attention="success"] > .toolbarbutton-badge-stack > #downloads-indicator-anchor > #downloads-indicator-icon,
    #downloads-button[attention="success"] > .toolbarbutton-badge-stack > #downloads-indicator-start-box > #downloads-indicator-start-image,
    #downloads-indicator-finish-image {
      fill: ${primary} !important;
      stroke: ${primary} !important;
    }

    #downloads-indicator-progress-inner {
      background: conic-gradient(${primary} var(--download-progress-pcent), transparent var(--download-progress-pcent)) !important;
    }

    #urlbar .search-panel-one-offs-header-label {
      color: ${foreground} !important;
      opacity: 1.0 !important;
    }

    #commonDialog {
      background: ${background-darker} !important;
    }

    .downloadProgress::-moz-progress-bar {
      background-color: ${primary} !important;
    }

    #tabbrowser-tabpanels {
      background: ${background-darker} !important;
    }

    .letterboxing {
      --letterboxing-bgcolor: ${background-darker} !important;
      --letterboxing-width: var(--rdm-width, 1600px);
      --letterboxing-height: var(--rdm-height, 900px);
      align-content: center;
    }

    /* Source file https://github.com/MrOtherGuy/firefox-csshacks/tree/master/chrome/hide_tabs_toolbar_v2.css made available under Mozilla Public License v. 2.0
    See the above repository for updates as well as full license text. */

    /* This requires Firefox 133+ to work */

    @media (-moz-bool-pref: "sidebar.verticalTabs"),
           -moz-pref("sidebar.verticalTabs"){
      #sidebar-main{
        visibility: collapse;
      }
    }
    @media (-moz-bool-pref: "userchrome.force-window-controls-on-left.enabled"),
           -moz-pref("userchrome.force-window-controls-on-left.enabled"){
      #nav-bar > .titlebar-buttonbox-container{
        order: -1 !important;
        > .titlebar-buttonbox{
          flex-direction: row-reverse;
        }
      }
    }
    @media not (-moz-bool-pref: "sidebar.verticalTabs"),
           not -moz-pref("sidebar.verticalTabs"){
      #TabsToolbar:not([customizing]){
        visibility: collapse;
      }
      :root[sizemode="fullscreen"] #nav-bar > .titlebar-buttonbox-container{
        display: flex !important;
      }
      :root:is([tabsintitlebar],[customtitlebar]) #toolbar-menubar:not([autohide="false"]) ~ #nav-bar{
        > .titlebar-buttonbox-container{
          display: flex !important;
        }
        :root[sizemode="normal"] & {
          > .titlebar-spacer{
            display: flex !important;
          }
        }
        :root[sizemode="maximized"] & {
          > .titlebar-spacer[type="post-tabs"]{
            display: flex !important;
          }
          @media (-moz-bool-pref: "userchrome.force-window-controls-on-left.enabled"),
            -moz-pref("userchrome.force-window-controls-on-left.enabled"),
            (-moz-gtk-csd-reversed-placement),
            (-moz-platform: macos){
            > .titlebar-spacer[type="post-tabs"]{
              display: none !important;
            }
            > .titlebar-spacer[type="pre-tabs"]{
              display: flex !important;
            }
          }
        }
      }
    }

    #sidebar-header {
      display: none;
    }

    /* Source file https://github.com/MrOtherGuy/firefox-csshacks/tree/master/chrome/urlbar_info_icons_on_hover.css made available under Mozilla Public License v. 2.0
    See the above repository for updates as well as full license text. */

    /* Hides info icons (except remote control icon) on the left side of urlbar and shows them when urlbar is hovered. Also hides container name and shows it on hover*/

    #urlbar-search-button,
    #tracking-protection-icon-container,
    #identity-box,
    #identity-box.extensionPage #identity-icon-label{
      max-width: 0px;
      transition: max-width 100ms linear !important;
      overflow: hidden;
    }

    #identity-box.extensionPage{ max-width: 32px }

    #urlbar:hover .urlbar-input-container > box,
    #urlbar:hover #identity-box.extensionPage #identity-icon-label{
      max-width: 300px;
    }
    #urlbar:not(:hover) #userContext-label{ display: none }
  '';
in
{
  programs.librewolf.profiles.default.userChrome = userChrome;
}
