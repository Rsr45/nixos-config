import Quickshell
import QtQuick 2.15
import qs.shared
import qs.modules

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData
            implicitHeight: 48
            anchors {
                top: true
                left: true
                right: true
            }
            margins {
                left: 10
                top: 10
                bottom: 10
            }
            color: Colors.backgroundColor

            Rectangle {
                anchors.fill: parent
                color: "transparent"

                // -----------------------
                // LEFT SECTION
                // -----------------------
                Row {
                    id: leftSection
                    spacing: 8
                    anchors.left: parent.left
                    y: Math.round((parent.height - height) / 2)  // pixel-align center

                    // Add modules here
                    // ClockWidget {}
                    // Weather {}
                }

                // -----------------------
                // CENTER SECTION
                // -----------------------
                Row {
                    id: centerSection
                    spacing: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: Math.round((parent.height - height) / 2)  // pixel-align center

                    // Add modules here
                    Weather {
                        // anchors.centerIn: parent
                    }

                    Rectangle {
                        width: 100
                        height: parent.height
                        color: "transparent"
                        ClockWidget {
                            width: 100
                            anchors.centerIn: parent
                            color: Colors.foregroundColor
                        }
                    }
                }

                // -----------------------
                // RIGHT SECTION
                // -----------------------
                //  Row {
                //      id: rightSection
                //      spacing: 8
                //      anchors.right: parent.right
                //      y: Math.round((parent.height - height) / 2)  // pixel-align center
                //
                //      Weather {}
                //      // Add modules here
                //      Item {
                //          width: 200
                //          height: parent.height  // fill the row height
                //          ClockWidget {
                //              width: 20
                //              height: 20
                //              color: Colors.foregroundColor
                //              anchors.centerIn: parent  // center it vertically
                //          }
                //      }
                //
                //      // Rectangle {
                //      //     width: 100
                //      //     height: parent.height   // fill the row height
                //      //     color: "transparent"
                //      //     ClockWidget {
                //      //         // width: 20
                //      //         // height: 20
                //      //         color: Colors.accentColor
                //      //         anchors.centerIn: parent
                //      //     }
                //      // }
                // }
            }
        }
    }
}
