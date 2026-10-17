import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import qs.shared

Rectangle {
    id: root

    Layout.alignment: Qt.AlignHCenter
    // anchors {
    //     top: parent.top
    //     // topMargin: 10
    //     horizontalCenter: parent.horizontalCenter
    // }

    width: 38
    radius: 0
    color: Colors.bgDarker
    border.width: 1
    border.color: Colors.border

    implicitHeight: column.implicitHeight + 16

    // Workspace → Nerd Font icon map
    readonly property var workspaceIcons: ({
            // 1: "" // terminal
            // ,
            // 2: "" // browser

            3: "" // code
            ,
            4: "" // files
            ,
            5: "" // music
        // ,
        // 6: "󰭹" // chat
        // ,
        // 7: "" // images
        // ,
        // 8: "" // media
        // ,
        // 9: ""  // settings
        })

    ColumnLayout {
        id: column
        anchors.centerIn: parent
        spacing: 5

        Repeater {
            model: Hyprland.workspaces

            delegate: Item {
                id: workspaceItem
                required property var modelData
                property bool hovered: false

                width: 28
                height: modelData.active ? 26 : 22
                Layout.alignment: Qt.AlignHCenter

                // Rectangle {
                //     anchors.fill: parent
                //     radius: 0
                //     color: "transparent"
                //     border.width: modelData.active ? 1 : 0
                //     border.color: Colors.accent
                // }

                // Nerd Font icon
                Text {
                    anchors.centerIn: parent
                    text: root.workspaceIcons[modelData.id] ?? ""
                    font.family: Config.icon   // Nerd Font
                    font.pixelSize: 16

                    color: modelData.active ? Colors.accent : hovered ? Colors.accentDarker : Colors.fg

                    Behavior on color {
                        ColorAnimation {
                            duration: 120
                        }
                    }
                }

                Behavior on height {
                    NumberAnimation {
                        duration: 180
                        easing.type: Easing.OutQuart
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true

                    onEntered: hovered = true
                    onExited: hovered = false

                    onClicked: {
                        Hyprland.dispatch(`hl.dsp.focus({ workspace = ${modelData.id} })`);
                    }

                    // onWheel: wheel => {
                    //     const dir = wheel.angleDelta.y > 0 ? "-1" : "+1";
                    //     Hyprland.dispatch("workspace e" + dir);
                    // }

                    onWheel: function (wheel) {
                        if (wheel.angleDelta.y > 0) {
                            Hyprland.dispatch("hl.dsp.focus({ workspace = \"e-1\" })");
                        } else if (wheel.angleDelta.y < 0) {
                            Hyprland.dispatch("hl.dsp.focus({ workspace = \"e+1\" })");
                        }

                        wheel.accepted = true;
                    }
                }
            }
        }
    }
}
