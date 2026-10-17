{
  config,
  lib,
  pkgs,
  ...
}: {
  networking.wg-quick.interfaces = {
    wg2 = {
      autostart = false;
      address = [
        "172.16.0.2/32"
        "2606:4700:110:8073:7642:3083:5718:7ca4/128"
      ];
      dns = [
        "1.1.1.1"
        "1.0.0.1"
        "2606:4700:4700::1111"
        "2606:4700:4700::1001"
      ];
      # privateKeyFile = config.age.secrets.wg-key-laptop.path;
      privateKey = "6P+ntvHx/4omkrpVW5GIePgX7R9GFXxsU621A/YDUls=";
      peers = [
        {
          publicKey = "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=";
          allowedIPs = [
            "0.0.0.0/0"
            "::/0"
          ];
          endpoint = "engage.cloudflareclient.com:2408";
        }
      ];
    };
    proton-no-free-10 = {
      autostart = false;
      address = [
        "10.2.0.2/32"
      ];
      dns = [
        "10.2.0.1"
      ];
      privateKey = "SO+KXP2tWLd7bsAnHHdBuqQLMkLshGuHXj8sdWouhmc=";
      peers = [
        {
          publicKey = "N9uq1Vwlu7tHTzG13/P/Plo8m4HJLeal8rdHeD96MxE=";
          allowedIPs = [
            "0.0.0.0/0"
            "::/0"
          ];
          endpoint = "95.173.205.161:51820";
        }
      ];
    };
    nl-79 = {
      autostart = false;
      address = [
        "10.2.0.2/32"
        "2a07:b944::2:2/128"
      ];
      dns = [
        "10.2.0.1"
        "2a07:b944::2:1"
      ];
      privateKey = "wFZZCMjYZ4cvtfakJk8gVJcns3M9P28MomcjRFngjXg=";
      peers = [
        {
          publicKey = "RGkflpj8nU73t7WgEmZQ45f+wF1QM3fDiKjimp5iCGA=";
          allowedIPs = [
            "0.0.0.0/0"
            "::/0"
          ];
          endpoint = "185.177.124.84:51820";
        }
      ];
    };
  };
}
