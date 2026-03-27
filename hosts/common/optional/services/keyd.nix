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
            # rightalt = "backspace";

            leftalt = "overloadt2(media, esc, 300)";
            space = "overloadt2(navigation, space, 300)";
            "6" = "overloadt2(mouse, tab, 300)";

            fn = "overloadt2(fun, delete, 300)";
            rightalt = "overloadt2(num, backspace, 300)";
            "9" = "overloadt2(sym, enter, 300)";

            "7" = "=";
            "8" = "7";
            # "9" = "8";
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
          "mouse" = {
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
            # ------------
            k = "mouseleft";
            l = "mousedown";
            semicolon = "mouseup";
            apostrophe = "mouseright";
            # -----------
            # comma = "home";
            # dot = "scrolldown";
            # slash = "scrollup";
            # rightshift = "end";

            rightalt = "leftmouse";
            "9" = "rightmouse";
          };
          "media" = {
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
            # ------------
            k = "previoussong";
            l = "volumedown";
            semicolon = "volumeup";
            apostrophe = "nextsong";

            rightalt = "playpause";
            "9" = "stopcd";

            g = "toggle(game)";
          };
          "num" = {
            q = "[";
            w = "7";
            e = "8";
            r = "9";
            t = "]";

            a = ";";
            s = "4";
            d = "5";
            f = "6";
            g = "=";

            "102nd" = "`";
            z = "1";
            x = "2";
            c = "3";
            v = "\\";

            leftalt = "dot";
            space = "0";
            "6" = "minus";

            k = "shift";
            l = "control";
            semicolon = "altgr";
            apostrophe = "meta";
          };
          "sym" = {
            q = "{";
            w = "&";
            e = "*";
            r = "(";
            t = "}";

            a = ":";
            s = "$";
            d = "%";
            f = "^";
            g = "+";

            "102nd" = "~";
            z = "!";
            x = "@";
            c = "#";
            v = "|";

            leftalt = "(";
            space = ")";
            "6" = "_";

            k = "shift";
            l = "control";
            semicolon = "altgr";
            apostrophe = "meta";
          };
          "fun" = {
            q = "f12";
            w = "f7";
            e = "f8";
            r = "f9";
            t = "sysrq"; # sysrq

            a = "f11";
            s = "f4";
            d = "f5";
            f = "f6";
            g = "scrolllock";

            "102nd" = "f10";
            z = "f1";
            x = "f2";
            c = "f3";
            v = "pause";

            leftalt = "compose";
            space = "space";
            "6" = "tab";

            k = "shift";
            l = "control";
            semicolon = "altgr";
            apostrophe = "meta";
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
