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
            implicitWidth: 48

            anchors {
                top: true
                left: true
                bottom: true
            }

            // margins {
            //     left: 10
            //     top: 10
            //     bottom: 10
            // }

            // color: Colors.bg
            // color: Qt.alpha(Colors.bg, 0.90)
            color: Colors.bg

            Rectangle {
                id: barRectangle
                anchors.fill: parent
                color: "transparent"

                border.width: 0
                border.color: Colors.border
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.horizontalCenter: parent.horizontalCenter
                // implicitWidth: Config.barWidth + Config.barBorderWidth

                ColumnLayout {
                    anchors {
                        fill: parent
                        // topMargin: 10
                        // bottomMargin: 10
                    }
                    spacing: 5

                    ReloadPopup {}

                    TopSection {
                        // Layout.fillHeight: false
                    }
                    CenterSection {
                        Layout.fillHeight: true
                    }
                    BottomSection {

                        // Layout.fillHeight: false
                    }
                }
            }
        }
    }
}
