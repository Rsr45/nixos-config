import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import qs.shared

RowLayout {
    id: root
    spacing: 0

    Repeater {
        model: Hyprland.workspaces

        delegate: Rectangle {
            required property var modelData

            property bool hovered: false

            width: 20
            height: 20

            visible: modelData.id >= 1 && modelData.id <= 10
            color: modelData.active ? Colors.accent : Colors.bg

            border.width: 0
            border.color: Colors.border

            Text {
                anchors.centerIn: parent

                text: modelData.id

                color: modelData.active ? Colors.bg : hovered ? Colors.accent : Colors.fg

                font.family: Config.font
                font.pixelSize: 16
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onEntered: hovered = true
                onExited: hovered = false

                onClicked: {
                    Hyprland.dispatch(`hl.dsp.focus({ workspace = ${modelData.id} })`);
                }
            }
        }
    }
}
