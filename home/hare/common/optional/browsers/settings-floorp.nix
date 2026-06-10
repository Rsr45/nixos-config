{ ... }:
{
  "userChrome.hidden.urlbar_iconbox" = true;
  "userChrome.hidden.tabbar" = true;
  "userChrome.hidden.sidebar_header" = true;
  "userChrome.centered.urlbar" = true;
  "userChrome.autohide.back_button" = false;
  "userChrome.autohide.forward_button" = false;
  "floorp.workspaces.enabled" = false;
  "floorp.panelSidebar.enabled" = false;

  "sidebar.revamp" = false;
  "sidebar.visibility" = "hide-sidebar";
  "browser.toolbars.bookmarks.visibility" = "never";

  "floorp.keyboardshortcut.enabled" = true;
  "floorp.keyboardshortcut.config" = builtins.toJSON {
    enabled = true;
    shortcuts = {
      "gecko-show-next-tab" = {
        modifiers = {
          alt = false;
          ctrl = true;
          meta = false;
          shift = false;
        };
        key = "N";
        action = "gecko-show-next-tab";
      };
      "gecko-show-previous-tab" = {
        modifiers = {
          alt = false;
          ctrl = true;
          meta = false;
          shift = false;
        };

        key = "P";
        action = "gecko-show-previous-tab";
      };

      "gecko-close-window" = {
        modifiers = {
          alt = false;
          ctrl = true;
          meta = false;
          shift = false;
        };
        key = "Q";
        action = "gecko-close-window";
      };

      # "gecko-scroll-up" = {
      #   action = "gecko-scroll-up";
      #   key = "U";
      #   modifiers = {
      #     alt = false;
      #     ctrl = true;
      #     meta = false;
      #     shift = false;
      #   };
      # };

      # "gecko-scroll-down" = {
      #   modifiers = {
      #     alt = false;
      #     ctrl = true;
      #     meta = false;
      #     shift = false;
      #   };
      #   key = "D";
      #   action = "gecko-scroll-down";
      # };
    };
  };

  "floorp.newtab.configs" = builtins.toJSON {
    components = {
      topSites = false;
      clock = true;
      searchBar = true;
      firefoxLayout = false;
    };
    background = {
      type = "random";
      customImage = null;
      fileName = null;
      folderPath = null;
      selectedFloorp = null;
      slideshowEnabled = false;
      slideshowInterval = 30;
    };
    searchBar = {
      searchEngine = "default";
    };
    topSites = {
      pinned = [
        {
          "url" = "https=//www.cube-soft.jp/";
          "title" = "Cubesoft (Sponsor)";
        }
        {
          "url" = "https=//docs.floorp.app/docs/features/";
          "title" = "Floorp Support";
        }
      ];
      blocked = [ ];
    };
  };

  "floorp.design.configs" = builtins.toJSON {
    globalConfigs = {
      userInterface = "lepton";
      faviconColor = false;
      appliedUserJs = "";
    };

    tabbar = {
      tabbarStyle = "horizontal";
      tabbarPosition = "optimise-to-vertical-tabbar";
      multiRowTabBar = {
        maxRowEnabled = false;
        maxRow = 3;
      };
    };

    tab = {
      tabScroll = {
        enabled = false;
        reverse = false;
        wrap = false;
      };
      tabMinHeight = 30;
      tabMinWidth = 76;
      tabPinTitle = false;
      tabDubleClickToClose = false;
      tabOpenPosition = -1;
    };

    uiCustomization = {
      navbar = {
        position = "top";
        searchBarTop = false;
      };

      display = {
        disableFullscreenNotification = false;
        deleteBrowserBorder = false;
      };

      special = {
        optimizeForTreeStyleTab = true;
        hideForwardBackwardButton = false;
        stgLikeWorkspaces = false;
      };

      multirowTab = {
        newtabInsideEnabled = false;
      };

      bookmarkBar = {
        focusExpand = false;
        position = "top";
      };

      qrCode = {
        disableButton = false;
      };
      disableFloorpStart = true;
    };
  };
}
