import QtQuick
import Quickshell
import Quickshell.Widgets
import QtQuick.Layouts
import Quickshell.Services.SystemTray
import qs.shared

Rectangle {
    id: trayRoot
    Layout.alignment: Qt.AlignHCenter
    width: 38
    // height: 78
    implicitHeight: tray.implicitHeight + 16
    radius: 0

    color: Colors.bgDarker
    border.width: 1
    border.color: Colors.border

    ColumnLayout {
        id: tray

        anchors.centerIn: parent
        spacing: 16

        Repeater {
            model: SystemTray.items

            delegate: Rectangle {
                required property var modelData

                height: 16
                width: 16
                Layout.alignment: Qt.AlignHCenter
                color: "transparent"

                Image {
                    anchors.centerIn: parent
                    width: 18
                    height: 18

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
}
