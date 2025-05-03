{ ... }:
{
  programs.schizofox.theme = {
    extraUserChrome = ''
                  /**
                  * Remove Sidebar Header
                  **/
                  #sidebar-header {
                    display: none;
                  }
                  /* .urlbarView { */
                  /*   display: none !important; */
                  /* } */
                  /* Source file https://github.com/MrOtherGuy/firefox-csshacks/tree/master/chrome/hide_tabs_toolbar.css made available under Mozilla Public License v. 2.0
                  See the above repository for updates as well as full license text. */

                  /* Hides tabs toolbar */
                  /* For OSX use hide_tabs_toolbar_osx.css instead */

                  /* Note, if you have either native titlebar or menubar enabled, then you don't really need this style.
                  * In those cases you can just use: #TabsToolbar{ visibility: collapse !important }
                  */

                  /* IMPORTANT */
                  /*
                  Get window_control_placeholder_support.css
                  Window controls will be all wrong without it
                  */

                  :root[tabsintitlebar]{ --uc-toolbar-height: 40px; }
                  :root[tabsintitlebar][uidensity="compact"]{ --uc-toolbar-height: 32px }
                  #titlebar{
                    will-change: unset !important;
                    transition: none !important;
                    opacity: 1 !important;
                  }
                  #TabsToolbar{ visibility: collapse !important }
                  :root[sizemode="fullscreen"] #titlebar{ position: relative }

                  :root[sizemode="fullscreen"] #TabsToolbar > .titlebar-buttonbox-container{
                    visibility: visible !important;
                    z-index: 2;
                  }

                  :root:not([inFullscreen]) #nav-bar{
                    margin-top: calc(0px - var(--uc-toolbar-height,0px));
                  }

                  :root[tabsintitlebar] #toolbar-menubar[autohide="true"]{
                    min-height: unset !important;
                    height: var(--uc-toolbar-height,0px) !important;
                    position: relative;
                  }

                  #toolbar-menubar[autohide="false"]{
                    margin-bottom: var(--uc-toolbar-height,0px)
                  }

                  :root[tabsintitlebar] #toolbar-menubar[autohide="true"] #main-menubar{
                    flex-grow: 1;
                    align-items: stretch;
                    background-attachment: scroll, fixed, fixed;
                    background-position: 0 0, var(--lwt-background-alignment), right top;
                    background-repeat: repeat-x, var(--lwt-background-tiling), no-repeat;
                    background-size: auto 100%, var(--lwt-background-size, auto auto), auto auto;
                    padding-right: 20px;
                  }
                  :root[tabsintitlebar] #toolbar-menubar[autohide="true"]:not([inactive]) #main-menubar{
                    background-color: var(--lwt-accent-color);
                    background-image: linear-gradient(var(--toolbar-bgcolor,--toolbar-non-lwt-bgcolor),var(--toolbar-bgcolor,--toolbar-non-lwt-bgcolor)), var(--lwt-additional-images,none), var(--lwt-header-image, none);
                    mask-image: linear-gradient(to left, transparent, black 20px);
                  }

                  #toolbar-menubar:not([inactive]){ z-index: 2 }
                  #toolbar-menubar[autohide="true"][inactive] > #menubar-items {
                    opacity: 0;
                    pointer-events: none;
                    margin-left: var(--uc-window-drag-space-pre,0px)
                  }


      /* 
      ┌─┐┬┌┬┐┌─┐┬  ┌─┐
      └─┐││││├─┘│  ├┤ 
      └─┘┴┴ ┴┴  ┴─┘└─┘
      ┌─┐┌─┐─┐ ┬      
      ├┤ │ │┌┴┬┘      
      └  └─┘┴ └─

      by Miguel Avila

      */

      /*
       
      ┌─┐┌─┐┌┐┌┌─┐┬┌─┐┬ ┬┬─┐┌─┐┌┬┐┬┌─┐┌┐┌
      │  │ ││││├┤ ││ ┬│ │├┬┘├─┤ │ ││ ││││
      └─┘└─┘┘└┘└  ┴└─┘└─┘┴└─┴ ┴ ┴ ┴└─┘┘└┘

      */

      :root {
        --sfwindow: #19171a;
        --sfsecondary: #201e21;
      }

      /* Urlbar View */

      /*─────────────────────────────*/
      /* Comment this section if you */
      /* want to show the URL Bar    */
      /*─────────────────────────────*/

      /* .urlbarView { */
      /*   display: none !important; */
      /* } */

      /*─────────────────────────────*/

      /* 
      ┌─┐┌─┐┬  ┌─┐┬─┐┌─┐
      │  │ ││  │ │├┬┘└─┐
      └─┘└─┘┴─┘└─┘┴└─└─┘ 
      */

      /* Tabs colors  */
      /* #tabbrowser-tabs:not([movingtab]) */
      /*   > #tabbrowser-arrowscrollbox */
      /*   > .tabbrowser-tab */
      /*   > .tab-stack */
      /*   > .tab-background[multiselected="true"], */
      /* #tabbrowser-tabs:not([movingtab]) */
      /*   > #tabbrowser-arrowscrollbox */
      /*   > .tabbrowser-tab */
      /*   > .tab-stack */
      /*   > .tab-background[selected="true"] { */
      /*   background-image: none !important; */
      /*   background-color: var(--toolbar-bgcolor) !important; */
      /* } */
      /**/
      /* /* Inactive tabs color */
      */
      /* #navigator-toolbox { */
      /*   background-color: var(--sfwindow) !important; */
      /* } */
      /**/
      /* /* Window colors  */ */
      /* :root { */
      /*   --toolbar-bgcolor: var(--sfsecondary) !important; */
      /*   --tabs-border-color: var(--sfsecondary) !important; */
      /*   --lwt-sidebar-background-color: var(--sfwindow) !important; */
      /*   --lwt-toolbar-field-focus: var(--sfsecondary) !important; */
      /* } */
      /**/
      /* /* Sidebar color  */ */
      /* #sidebar-box, */
      /* .sidebar-placesTree { */
      /*   background-color: var(--sfwindow) !important; */
      /* } */

      /* 

      ┌┬┐┌─┐┬  ┌─┐┌┬┐┌─┐            
       ││├┤ │  ├┤  │ ├┤             
      ─┴┘└─┘┴─┘└─┘ ┴ └─┘            
      ┌─┐┌─┐┌┬┐┌─┐┌─┐┌┐┌┌─┐┌┐┌┌┬┐┌─┐
      │  │ ││││├─┘│ ││││├┤ │││ │ └─┐
      └─┘└─┘┴ ┴┴  └─┘┘└┘└─┘┘└┘ ┴ └─┘

      */

      /* Tabs elements  */
      .tab-close-button {
        display: none;
      }

      .tabbrowser-tab:not([pinned]) .tab-icon-image {
        display: none !important;
      }

      #nav-bar:not([tabs-hidden="true"]) {
        box-shadow: none;
      }

      #tabbrowser-tabs[haspinnedtabs]:not([positionpinnedtabs])
        > #tabbrowser-arrowscrollbox
        > .tabbrowser-tab[first-visible-unpinned-tab] {
        margin-inline-start: 0 !important;
      }

      :root {
        --toolbarbutton-border-radius: 0 !important;
        --tab-border-radius: 0 !important;
        --tab-block-margin: 0 !important;
      }

      .tab-background {
        border-right: 0px solid rgba(0, 0, 0, 0) !important;
        margin-left: -4px !important;
      }

      .tabbrowser-tab:is([visuallyselected="true"], [multiselected])
        > .tab-stack
        > .tab-background {
        box-shadow: none !important;
      }

      .tabbrowser-tab[last-visible-tab="true"] {
        padding-inline-end: 0 !important;
      }

      #tabs-newtab-button {
        padding-left: 0 !important;
      }

      /* Url Bar  */
      #urlbar-input-container {
        background-color: var(--sfsecondary) !important;
        border: 1px solid rgba(0, 0, 0, 0) !important;
      }

      #urlbar-container {
        margin-left: 0 !important;
      }

      #urlbar[focused="true"] > #urlbar-background {
        box-shadow: none !important;
      }

      #navigator-toolbox {
        border: none !important;
      }

      /* Bookmarks bar  */
      .bookmark-item .toolbarbutton-icon {
        display: none;
      }
      toolbarbutton.bookmark-item:not(.subviewbutton) {
        min-width: 1.6em;
      }

      /* Toolbar  */
      #tracking-protection-icon-container,
      #urlbar-zoom-button,
      #star-button-box,
      #pageActionButton,
      #pageActionSeparator,
      #tabs-newtab-button,
      #back-button,
      #PanelUI-button,
      #forward-button,
      .tab-secondary-label {
        display: none !important;
      }

      .urlbarView-url {
        color: #dedede !important;
      }

      /* Disable elements  */
      /* #context-navigation, */
      /* #context-savepage, */
      /* #context-pocket, */
      /* #context-sendpagetodevice, */
      /* #context-selectall, */
      /* #context-viewsource, */
      /* #context-inspect-a11y, */
      /* #context-sendlinktodevice, */
      /* #context-openlinkinusercontext-menu, */
      /* #context-bookmarklink, */
      /* #context-savelink, */
      /* #context-savelinktopocket, */
      /* #context-sendlinktodevice, */
      /* #context-searchselect, */
      /* #context-sendimage, */
      /* #context-print-selection { */
      /*   display: none !important; */
      /* } */
      /**/
      /* #context_bookmarkTab, */
      /* #context_moveTabOptions, */
      /* #context_sendTabToDevice, */
      /* #context_reopenInContainer, */
      /* #context_selectAllTabs, */
      /* #context_closeTabOptions { */
      /*   display: none !important; */
      /* } */
    '';

  };
}
