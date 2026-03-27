{ lib, ... }:
{
  imports = [
    ./search.nix
    ./extensions.nix
  ];

  programs.firefox.profiles.phoenix = {
    id = 1;
    extraConfig =
      builtins.replaceStrings [ "\npref(" ] [ "\nuser_pref(" ] (
        builtins.readFile ../../phoenix-desktop.js
      )
      + builtins.readFile ../../preferred.js;
    userChrome = builtins.readFile ./userChrome.css;
    userContent = builtins.readFile ./userContent.css;
    settings = {
    };

    containersForce = true;
    containers = {
      dangerous = {
        color = "red";
        icon = "fruit";
        id = 5;
      };
      shopping = {
        color = "pink";
        icon = "cart";
        id = 3;
      };
      bank = {
        color = "green";
        icon = "dollar";
        id = 4;
      };
      work = {
        color = "orange";
        icon = "briefcase";
        id = 2;
      };
      personal = {
        color = "blue";
        icon = "fingerprint";
        id = 1;
      };
      school = {
        color = "yellow";
        icon = "circle";
        id = 6;
      };
      google = {
        color = "toolbar";
        icon = "circle";
        id = 7;
      };
      youtube = {
        color = "toolbar";
        icon = "circle";
        id = 8;
      };
      goon = {
        color = "toolbar";
        icon = "circle";
        id = 9;
      };
      tmp = {
        color = "toolbar";
        icon = "circle";
        id = 10;
      };
      ai = {
        color = "toolbar";
        icon = "circle";
        id = 11;
      };
      misc = {
        color = "toolbar";
        icon = "circle";
        id = 12;
      };
      whatsapp = {
        color = "green";
        icon = "circle";
        id = 13;
      };
    };
  };
}
