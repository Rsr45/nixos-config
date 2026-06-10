import Quickshell
import QtQuick
import qs.shared

import QtQuick.Shapes
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Widgets
import Quickshell.Wayland
import QtQuick.Window
import Quickshell.Services.UPower
import Quickshell.Services.SystemTray
import Quickshell.Services.Pipewire
import Quickshell.Services.Mpris

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData
            implicitHeight: 20

            anchors {
                bottom: true
                left: true
                right: true
            }

            // margins {
            //     left: 10
            //     top: 10
            //     bottom: 10
            // }

            // color: Colors.bg
            // color: Qt.alpha(Colors.bg, 0.65)
            color: Colors.bgAlt

            Rectangle {
                id: barRectangle
                anchors.fill: parent
                color: "transparent"

                border.width: 0
                border.color: Colors.border
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.horizontalCenter: parent.horizontalCenter
                // implicitWidth: Config.barWidth + Config.barBorderWidth

                RowLayout {
                    anchors {
                        fill: parent
                        // topMargin: 10
                        // bottomMargin: 10
                    }
                    spacing: 5

                    ReloadPopup {}

                    LeftSection {
                        // Layout.fillHeight: false
                    }
                    CenterSection {
                        Layout.fillWidth: true
                    }
                    RightSection {

                        // Layout.fillHeight: false
                    }
                }
            }
        }
    }
}
