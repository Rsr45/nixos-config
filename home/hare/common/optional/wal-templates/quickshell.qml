pragma Singleton
import Quickshell
import QtQuick

Singleton {
    property color bg: "{{ background }}"
    property color bgDarker: "{{ background | darken(0.3) }}"
    property color border: "{{ background | lighten(0.1)}}"
    property color fg: "{{ foreground }}"
    property color accent: "{{ color4 }}"
    property color accentDarker: "{{ color4 | darken(0.2) }}"
    property color accent2: "{{ color3 }}"
    property color accent2Darker: "{{ color3 | darken(0.2) }}"

    property color backgroundColor: "{{ background }}"
    property color foregroundColor: "{{ foreground }}"
    property color indicatorBGColor: "{{ color4 | darken(0.3) }}"
    property color borderColor: "{{ background }}"
    property color moduleBG: "{{ background | lighten(0.01) }}"
    property color accentColor: "{{ color4 }}"
    property color accent2Color: "{{ color4 }}"
    property color gradientAccent2Color: "{{ color4 }}"  //bottom / right of volume bar
    property color errorColor: "#9A4235"
    property color shadowColor: "#CC784d37"  // this applies to the dashboard shadow as well. you can disable shadow from config

    // dashboard related colors
    property color dashBGColor: "#2b221a"
    property color dashModulesColor: "#3d2e21" // color of the inner modules / rectangles
    property color dashBorderColor: "#3A2D22"     // this is used in the borders / border circle around pfp
    property color dashPFPColor: "#2b221a"   // circle around pfp
    // ========================================those are specific to the contribution squares in the commit graph
    property color level0Contrib: "#5c3d2d"
    property color level1Contrib: "#9e6d54"
    property color level2Contrib: "#cf9174"
    property color level3Contrib: "#db9d7f"
    property color level4Contrib: "#f7b292"
    //========================================
    property color powerButtons: "#2b221a"  // bg color of the buttons (used in all buttons for consistency)
    //========================================
    property color dashAccentColor: "#3A2D00"  // ignore this
}
