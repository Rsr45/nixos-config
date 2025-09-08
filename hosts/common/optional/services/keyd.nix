{ ... }:
{
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            escape = "capslock";
            capslock = "esc";
            rightalt = "backspace";

            space = "overloadt2(navigation, space, 300)";

            "7" = "=";
            "8" = "7";
            "9" = "8";
            "0" = "9";
            minus = "0";
            equal = "minus";

            q = "q";
            w = "w";
            e = "f";
            r = "p";
            t = "b";
            y = "[";
            u = "j";
            i = "l";
            o = "u";
            p = "y";
            leftbrace = ";";
            rightbrace = "/";

            a = "overloadt2(meta, a, 300)";
            s = "overloadt2(altgr, r, 200)";
            d = "overloadt2(control, s, 200)";
            f = "overloadt2(shift, t, 200)";
            g = "g";
            h = "]";
            j = "m";
            k = "overloadt2(shift, n, 200)";
            l = "overloadt2(control, e, 200)";
            semicolon = "overloadt2(altgr, i, 200)";
            apostrophe = "overloadt2(meta, o, 300)";
            backslash = "'";

            "102nd" = "z";
            z = "x";
            x = "c";
            c = "d";
            v = "v";
            b = "\\";
            n = "#";
            m = "k";
            comma = "h";
            dot = ",";
            slash = ".";
          };
          "shift:S" = {
            n = "~";
          };
          "alt" = {
            g = "toggle(game)";
          };
          "navigation" = {
            # left hand
            # ------------
            a = "meta ";
            s = "altgr";
            d = "control";
            f = "shift";
            # right hand
            # ------------
            u = "redo";
            i = "paste";
            o = "copy";
            p = "cut";
            leftbrace = "undo";
            rightbrace = "delete";
            # ------------
            j = "capslock";
            k = "left";
            l = "down";
            semicolon = "up";
            apostrophe = "right";
            backslash = "enter";
            # -----------
            m = "insert";
            comma = "home";
            dot = "pagedown";
            slash = "pageup";
            rightshift = "end";
          };
          "game" = {
            space = "space";

            q = "tab";
            w = "q";
            e = "w";
            r = "e";
            t = "r";
            y = "t";
            u = "y";
            i = "u";
            o = "i";
            p = "o";
            leftbrace = "p";

            a = "leftshift";
            s = "a";
            d = "s";
            f = "d";
            g = "f";
            h = "g";
            k = "h";

            "102nd" = "leftcontrol";
            z = "z";
            x = "x";
            c = "c";
            # v = "v";
            b = "b";
            n = "n";
            m = "m";
          };
        };
      };
    };
  };
}
