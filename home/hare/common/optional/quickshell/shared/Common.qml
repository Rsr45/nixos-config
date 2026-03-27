pragma Singleton

import QtQuick
import Quickshell
import qs.shared

Singleton {

  // User Configuration
  readonly property string cUsername: Quickshell.env("USER") || "user"
  readonly property string cConfigPath: Quickshell.env("HOME") + "/.config/quickshell"
  readonly property string cProfilePath:  Quickshell.env("HOME") + "/Personal/pfp.png"  // profile pic in the dashboard
  readonly property string cGithubUsername: "Rsr45"   // obviously, if you aren't me, which you aren't, just change this into you github username
  readonly property string cFileManager: "yazi" // or change it to "yazi", or "thunar" or whatever file manager you like
  readonly property string cBrowser: "firefox" // or whatever browser you like
  readonly property string cTerminal: "kitty" // same thing here

  readonly property bool cShowLightBar: true

  // tweak this if your dashboard has weird proportions because of screen size
  readonly property double cDashboardWidth: 3.5
  readonly property double cDashboardHeight: 0.35

  readonly property bool cEnableCat: false // set this to true to have the cat at the top of the bar
                                          // I disabled the cat by default because it looks weird when I theme-switch, but
                                         // you can also just kick it off by clicking on it, before switching themes.
}
