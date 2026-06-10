{ config, ... }:
{
  sidebar = {
    panels = {
      f3Bkupiyh4rd = {
        type = 2;
        id = "f3Bkupiyh4rd";
        name = "Tabs";
        color = "toolbar";
        iconSVG = "icon_tabs";
        iconIMGSrc = "";
        iconIMG = "";
        lockedPanel = false;
        skipOnSwitching = false;
        noEmpty = false;
        newTabCtx = "none";
        dropTabCtx = "none";
        moveRules = [
        ];
        moveExcludedTo = -1;
        bookmarksFolderId = -1;
        newTabBtns = [ ];
        srcPanelConfig = null;
      };

      Zx7VqLm2Np8R = {
        type = 2;
        id = "Zx7VqLm2Np8R";
        name = "School";
        color = "yellow";
        iconSVG = "icon_tabs";
        iconIMGSrc = "";
        iconIMG = "";
        lockedPanel = false;
        skipOnSwitching = false;
        noEmpty = false;
        newTabCtx = "firefox-container-6";
        dropTabCtx = "none";
        moveRules = [
        ];
        moveExcludedTo = -1;
        bookmarksFolderId = -1;
        newTabBtns = [
          "canva" # newline is empty quotes eg ""
        ];
        srcPanelConfig = null;
      };

      Rt8YpK3mVx6Q = {
        type = 2;
        id = "Rt8YpK3mVx6Q";
        name = "Shopping";
        color = "pink";
        iconSVG = "icon_tabs";
        iconIMGSrc = "";
        iconIMG = "";
        lockedPanel = false;
        skipOnSwitching = false;
        noEmpty = false;
        newTabCtx = "firefox-container-3";
        dropTabCtx = "none";
        moveRules = [
          {
            id = "VfDX4TzvoTUW";
            active = true;
            url = "/^https?://([0-9A-Za-z-]{1,63}\\.)*www\\.amazon\\.com\\.tr/";
            topLvlOnly = false;
            name = "www.amazon.com.tr";
          }
          {
            id = "VcDh4TzvUTUw";
            active = true;
            url = "/^https?://([0-9A-Za-z-]{1,63}\\.)*www\\.hepsiburada\\.com/";
            topLvlOnly = false;
            name = "www.hepsiburada.com";
          }
        ];
        moveExcludedTo = -1;
        bookmarksFolderId = -1;
        newTabBtns = [ ];
        srcPanelConfig = null;
      };
      SzihNPavyPVW = {
        "type" = 1;
        "id" = "SzihNPavyPVW";
        "name" = "Bookmarks";
        "iconSVG" = "icon_bookmarks";
        "iconIMGSrc" = "";
        "iconIMG" = "";
        "color" = "toolbar";
        "lockedPanel" = false;
        "tempMode" = false;
        "skipOnSwitching" = false;
        "rootId" = "root________";
        "viewMode" = "tree";
        "autoConvert" = false;
        "srcPanelConfig" = null;
      };
      # "sync": {
      #   "type": 5,
      #   "id": "sync",
      #   "name": "Sync",
      #   "color": "toolbar",
      #   "iconSVG": "icon_sync",
      #   "tempMode": false,
      #   "lockedPanel": false,
      #   "skipOnSwitching": false,
      #   "viewMode": "sync"
      # },
      "history" = {
        "type" = 4;
        "id" = "history";
        "name" = "History";
        "color" = "toolbar";
        "iconSVG" = "icon_clock";
        "tempMode" = false;
        "lockedPanel" = false;
        "skipOnSwitching" = false;
        "viewMode" = "history";
      };
    };
    # avilable modules to use in sidebar
    #    "f3Bkupiyh4rd", # tabs panel use the id of the tab
    #    "add_tp", # new tab create button
    #    "sp-0", # dynamic space up the number  eg 1-2-3-4-etc
    #    "sd-_Tz_rqQLcNVW", # delimiter after sd- needs a unique id same idea as every id field
    #    "remute_audio_tabs",  # mute unmute
    #    "SzihNPavyPVW", # bookmarks uses unique id too igues considering you can put as much as you want
    #    "search",
    #    "create_snapshot",
    #    "collapse",
    #    "sync",
    #    "hdn",
    #    "history",
    #    "settings",
    #    "sd-KFWEWOokGbWW"

    nav = [
      "search"
      "sd-_Tz_rqQLcNVW"
      "f3Bkupiyh4rd"
      "Zx7VqLm2Np8R"
      "Rt8YpK3mVx6Q"
      "sd-zTz_rQlLuNVW"
      "SzihNPavyPVW" # Bookmarks Panel see the panel that uses this id
      "history"
      "remute_audio_tabs"
      "sp-0"
      "sd-Rwx_LqlLuNnW"
      "settings"
    ];
  };
}
