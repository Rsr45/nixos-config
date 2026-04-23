{ ... }:
{
  accounts.email.accounts = {
    "efe54676@gmail.com" = {
      primary = true;
      realName = "Muhittin Efe Kaygısız";
      address = "efe54676@gmail.com";
      flavor = "gmail.com";
      passwordCommand = "secret-tool lookup email efe54676@gmail.com";
      mbsync = {
        enable = true;
        create = "maildir";
      };
      msmtp.enable = true;
      thunderbird.enable = true;
      neomutt.enable = true;
      meli.enable = true;
    };
    "efe45676@gmail.com" = {
      realName = "Muhittin Efe Kaygısız";
      address = "efe45676@gmail.com";
      flavor = "gmail.com";
      passwordCommand = "secret-tool lookup email efe45676@gmail.com";
      mbsync = {
        enable = true;
        create = "maildir";
      };
      msmtp.enable = true;
      thunderbird.enable = true;
      neomutt.enable = true;
      meli.enable = true;
    };
  };
}
