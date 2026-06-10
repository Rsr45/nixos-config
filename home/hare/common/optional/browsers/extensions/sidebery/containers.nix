{ config, ... }:
{
  containers = {
    firefox-container-1 = {
      id = "firefox-container-1";
      cookieStoreId = "firefox-container-1";
      name = "personal";
      icon = "fingerprint";
      color = "blue";
      colorCode = "#37adff";
      proxified = false;
      proxy = null;
      reopenRulesActive = false;
      reopenRules = [ ];
      userAgentActive = false;
      userAgent = "";
    };
    firefox-container-2 = {
      id = "firefox-container-2";
      cookieStoreId = "firefox-container-2";
      name = "work";
      icon = "briefcase";
      color = "orange";
      colorCode = "#37adff";
      proxified = false;
      proxy = null;
      reopenRulesActive = false;
      reopenRules = [ ];
      userAgentActive = false;
      userAgent = "";
    };
    firefox-container-3 = {
      id = "firefox-container-3";
      cookieStoreId = "firefox-container-3";
      name = "shopping";
      icon = "cart";
      color = "pink";
      colorCode = "#37adff";
      proxified = false;
      proxy = null;
      reopenRulesActive = false;
      reopenRules = [ ];
      userAgentActive = false;
      userAgent = "";
    };
    firefox-container-4 = {
      id = "firefox-container-4";
      cookieStoreId = "firefox-container-4";
      name = "bank";
      icon = "dollar";
      color = "green";
      colorCode = "#37adff";
      proxified = false;
      proxy = null;
      reopenRulesActive = false;
      reopenRules = [ ];
      userAgentActive = false;
      userAgent = "";
    };
    firefox-container-6 = {
      id = "firefox-container-6";
      cookieStoreId = "firefox-container-6";
      name = "school";
      icon = "circle";
      color = "yellow";
      colorCode = "#37adff";
      proxified = false;
      proxy = null;
      reopenRulesActive = true;
      reopenRules = [
        {
          id = "FGLxUttezvpW";
          active = true;
          type = 1;
          url = "/^https?://([0-9A-Za-z-]{1,63}\\.)*ikc\\.edu\\.tr/";
          name = "ikc.edu.tr";
        }
      ];
      userAgentActive = false;
      userAgent = "";
    };
    firefox-container-11 = {
      "id" = "firefox-container-11";
      "cookieStoreId" = "firefox-container-11";
      "name" = "ai";
      "icon" = "circle";
      "color" = "toolbar";
      "colorCode" = "#37adff";
      "proxified" = false;
      "proxy" = null;
      "reopenRulesActive" = true;
      "reopenRules" = [
        {
          "id" = "_aIZxt1qlXbg";
          "active" = true;
          "type" = 1;
          "url" = "/^https?://([0-9A-Za-z-]{1,63}\\.)*chatgpt\\.com/";
          "name" = "chatgpt.com";
        }
      ];
      "userAgentActive" = false;
      "userAgent" = "";
    };
    "firefox-container-5" = {
      "id" = "firefox-container-5";
      "cookieStoreId" = "firefox-container-5";
      "name" = "dangerous";
      "icon" = "fruit";
      "color" = "red";
      "colorCode" = "#37adff";
      "proxified" = false;
      "proxy" = null;
      "reopenRulesActive" = false;
      "reopenRules" = [ ];
      "userAgentActive" = false;
      "userAgent" = "";
    };
    "firefox-container-7" = {
      id = "firefox-container-7";
      cookieStoreId = "firefox-container-7";
      name = "google";
      icon = "circle";
      color = "toolbar";
      colorCode = "#37adff";
      proxified = false;
      proxy = null;
      reopenRulesActive = false;
      reopenRules = [
        {
          "id" = "Qn4TbX7pLs2K";
          "active" = true;
          "type" = 1;
          "url" = "/^https?://([0-9A-Za-z-]{1,63}\\.)*accounts\\.google\\.com/";
          "name" = "accounts.google.com";
        }
      ];
      userAgentActive = false;
      userAgent = "";
    };
    "firefox-container-9" = {
      "id" = "firefox-container-9";
      "cookieStoreId" = "firefox-container-9";
      "name" = "goon";
      "icon" = "circle";
      "color" = "toolbar";
      "colorCode" = "#37adff";
      "proxified" = false;
      "proxy" = null;
      "reopenRulesActive" = true;
      "reopenRules" = [
        {
          "id" = "UgPpSu9zM0as";
          "active" = true;
          "type" = 1;
          "url" = "/^https?://([0-9A-Za-z-]{1,63}\\.)*x\\.com/";
          "name" = "x.com";
        }
        {
          "id" = "Kf8LmQ2xVa7P";
          "active" = true;
          "type" = 1;
          "url" = "/^https?://([0-9A-Za-z-]{1,63}\\.)*pixiv\\.net/";
          "name" = "x.com";
        }
      ];
      "userAgentActive" = false;
      "userAgent" = "";
    };
    "firefox-container-12" = {
      "id" = "firefox-container-12";
      "cookieStoreId" = "firefox-container-12";
      "name" = "misc";
      "icon" = "circle";
      "color" = "toolbar";
      "colorCode" = "#37adff";
      "proxified" = false;
      "proxy" = null;
      "reopenRulesActive" = false;
      "reopenRules" = [ ];
      "userAgentActive" = false;
      "userAgent" = "";
    };
    "firefox-container-10" = {
      "id" = "firefox-container-10";
      "cookieStoreId" = "firefox-container-10";
      "name" = "tmp";
      "icon" = "circle";
      "color" = "toolbar";
      "colorCode" = "#37adff";
      "proxified" = false;
      "proxy" = null;
      "reopenRulesActive" = false;
      "reopenRules" = [ ];
      "userAgentActive" = false;
      "userAgent" = "";
    };
    "firefox-container-13" = {
      "id" = "firefox-container-13";
      "cookieStoreId" = "firefox-container-13";
      "name" = "whatsapp";
      "icon" = "circle";
      "color" = "green";
      "colorCode" = "#37adff";
      "proxified" = false;
      "proxy" = null;
      "reopenRulesActive" = true;
      "reopenRules" = [
        {
          "id" = "HZPBm7lS9IRf";
          "active" = true;
          "type" = 1;
          "url" = "/^https?://([0-9A-Za-z-]{1,63}\\.)*web\\.whatsapp\\.com/";
          "name" = "web.whatsapp.com";
        }
      ];
      "userAgentActive" = false;
      "userAgent" = "";
    };
    "firefox-container-8" = {
      "id" = "firefox-container-8";
      "cookieStoreId" = "firefox-container-8";
      "name" = "youtube";
      "icon" = "circle";
      "color" = "toolbar";
      "colorCode" = "#37adff";
      "proxified" = false;
      "proxy" = null;
      "reopenRulesActive" = true;
      "reopenRules" = [
        {
          "id" = "pN9u2NSHu3zd";
          "active" = true;
          "type" = 1;
          "url" = "/^https?://([0-9A-Za-z-]{1,63}\\.)*www\\.youtube\\.com/";
          "name" = "www.youtube.com";
        }
      ];
      "userAgentActive" = false;
      "userAgent" = "";
    };
    "firefox-container-14" = {
      "id" = "firefox-container-14";
      "cookieStoreId" = "firefox-container-14";
      "name" = "reddit";
      "icon" = "circle";
      "color" = "toolbar";
      "colorCode" = "#37adff";
      "proxified" = false;
      "proxy" = null;
      "reopenRulesActive" = true;
      "reopenRules" = [
        {
          "id" = "FIAgHxV15Qgm";
          "active" = true;
          "type" = 1;
          "url" = "/^https?://([0-9A-Za-z-]{1,63}\\.)*reddit\\.com/";
          "name" = "reddit.com";
        }
      ];
      "userAgentActive" = false;
      "userAgent" = "";
    };
    "firefox-container-15" = {
      "id" = "firefox-container-15";
      "cookieStoreId" = "firefox-container-15";
      "name" = "dev";
      "icon" = "circle";
      "color" = "turquoise";
      "colorCode" = "#37adff";
      "proxified" = false;
      "proxy" = null;
      "reopenRulesActive" = true;
      "reopenRules" = [
        {
          "id" = "nUBa4FTaZJdm";
          "active" = true;
          "type" = 1;
          "url" = "/^https?://([0-9A-Za-z-]{1,63}\\.)*github\\.com/";
          "name" = "github.com";
        }
      ];
      "userAgentActive" = false;
      "userAgent" = "";
    };
    "firefox-container-16" = {
      "id" = "firefox-container-16";
      "cookieStoreId" = "firefox-container-16";
      "name" = "norway";
      "icon" = "circle";
      "color" = "red";
      "colorCode" = "#37adff";
      "proxified" = false;
      "proxy" = null;
      "reopenRulesActive" = false;
      "reopenRules" = [ ];
      "userAgentActive" = false;
      "userAgent" = "";
    };
    firefox-container-17 = {
      id = "firefox-container-17";
      cookieStoreId = "firefox-container-17";
      name = "canva";
      icon = "circle";
      color = "toolbar";
      colorCode = "#37adff";
      proxified = false;
      proxy = null;
      reopenRulesActive = true;
      reopenRules = [
        {
          id = "FGlxUtXczvpW";
          active = true;
          type = 1;
          url = "/^https?://([0-9A-Za-z-]{1,63}\\.)*canva\\.com/";
          name = "canva.com";
        }
      ];
      userAgentActive = false;
      userAgent = "";
    };
  };
}
