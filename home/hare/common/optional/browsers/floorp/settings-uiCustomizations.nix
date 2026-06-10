{ ... }:
{
  "browser.uiCustomization.state" = builtins.toJSON {
    placements = {
      widget-overflow-fixed-list = [
        "developer-button"
        "edit-controls"
        "email-link-button"
        "characterencoding-button"
        "zoom-controls"
      ];

      unified-extensions-area = [
        "addon_darkreader_org-browser-action"
        "_3c078156-979c-498b-8990-85f7987dd929_-browser-action"
        "sponsorblocker_ajay_app-browser-action"
        "_d07ccf11-c0cd-4938-a265-2a4d6ad01189_-browser-action"
        "firefox-extension_steamdb_info-browser-action"
        "_aecec67f-0d10-4fa7-b7c7-609a2db280cf_-browser-action"
        "_7a7a4a92-a2a0-41d1-9fd7-1e92480d612d_-browser-action"
      ];

      nav-bar = [
        "sidebar-button"
        "back-button"
        "forward-button"
        "vertical-spacer"
        "firefox-view-button"
        "stop-reload-button"
        "home-button"
        "customizableui-special-spring12"
        "customizableui-special-spring13"
        "customizableui-special-spring17"
        "customizableui-special-spring18"
        "urlbar-container"
        "_testpilot-containers-browser-action"
        "reset-pbm-toolbar-button"
        "customizableui-special-spring24"
        "customizableui-special-spring23"
        "customizableui-special-spring15"
        "customizableui-special-spring14"
        "downloads-button"
        "ublock0_raymondhill_net-browser-action"
        "adnauseam_rednoise_org-browser-action"
        "unified-extensions-button"
      ];

      toolbar-menubar = [ "menubar-items" ];
      TabsToolbar = [
        "tabbrowser-tabs"
        "new-tab-button"
      ];
      vertical-tabs = [ ];
      PersonalToolbar = [ "personal-bookmarks" ];
      nora-statusbar = [
        "screenshot-button"
        "fullscreen-button"
        "status-text"
      ];
    };
    seen = [
      "reset-pbm-toolbar-button"
      "developer-button"
      "_testpilot-containers-browser-action"
      "ublock0_raymondhill_net-browser-action"
      "adnauseam_rednoise_org-browser-action"
      "screenshot-button"
      "addon_darkreader_org-browser-action"
      "_d07ccf11-c0cd-4938-a265-2a4d6ad01189_-browser-action"
      "_3c078156-979c-498b-8990-85f7987dd929_-browser-action"
      "firefox-extension_steamdb_info-browser-action"
      "_aecec67f-0d10-4fa7-b7c7-609a2db280cf_-browser-action"
      "_7a7a4a92-a2a0-41d1-9fd7-1e92480d612d_-browser-action"
      "sponsorblocker_ajay_app-browser-action"
      "profile-manager-button"
      "undo-closed-tab"
    ];
    dirtyAreaCache = [
      "nav-bar"
      "vertical-tabs"
      "PersonalToolbar"
      "unified-extensions-area"
      "TabsToolbar"
      "toolbar-menubar"
      "nora-statusbar"
      "widget-overflow-fixed-list"
    ];
    currentVersion = 23;
    newElementCount = 26;
  };
}
