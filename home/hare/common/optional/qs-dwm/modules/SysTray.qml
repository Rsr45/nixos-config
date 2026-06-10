import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray
import qs.shared

RowLayout {
    id: root

    spacing: 6

    Repeater {
        model: SystemTray.items

        delegate: Rectangle {
            required property var modelData

            width: 18
            height: 18
            color: "transparent"

            Image {
                anchors.centerIn: parent
                width: 14
                height: 14

                source: modelData.icon ?? ""
                fillMode: Image.PreserveAspectFit
            }

            MouseArea {
                anchors.fill: parent

                onClicked: modelData.activate()

                onPressed: mouse => {
                    if (mouse.button === Qt.RightButton)
                        modelData.contextMenu()
                }
            }
        }
    }
}
