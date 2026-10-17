import QtQuick
import Quickshell
import Quickshell.Widgets
import QtQuick.Layouts
import Quickshell.Services.SystemTray
import qs.shared

RowLayout {
    // id: root
    id: trayRoot

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

                // onClicked: modelData.activate()
                acceptedButtons: Qt.LeftButton | Qt.RightButton

                onClicked: mouse => {
                    let itemId = modelData.id.toLowerCase();

                    if (mouse.button === Qt.RightButton) {
                        if (modelData.hasMenu) {
                            // Map mouse coordinates to the root window space
                            let windowPos = mapToItem(null, mouse.x, mouse.y);
                            modelData.display(trayRoot.QsWindow.window, Math.round(windowPos.x), Math.round(windowPos.y));
                        } else {
                            modelData.secondaryActivate();
                        }
                    } else {
                        modelData.activate();
                    }
                }
            }
        }
    }
}
