pragma Singleton
import Quickshell
import QtQuick

Singleton {
    property color bg: "#262626"
    property color bgDarker: "#1B1B1B"
    property color border: "#3C3C3C"
    property color fg: "#DAB997"
    property color accent: "#83ADAD"
    property color accentDarker: "#698A8A"
    property color accent2: "#FFAF00"
    property color accent2Darker: "#CC8C00"

    property color backgroundColor: "#262626"
    property color foregroundColor: "#DAB997"
    property color indicatorBGColor: "#5C7979"
    property color borderColor: "#262626"
    property color moduleBG: "#282828"
    property color accentColor: "#83ADAD"
    property color accent2Color: "#83ADAD"
    property color gradientAccent2Color: "#83ADAD"  //bottom / right of volume bar
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
