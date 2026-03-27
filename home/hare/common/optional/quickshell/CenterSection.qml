import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.modules

Rectangle {
    Layout.fillHeight: true
    Layout.fillWidth: true
    color: "transparent"

    ColumnLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        Layout.fillHeight: true
        Layout.fillWidth: true
        spacing: 5
        y: (bar.height - height) / 12

        // Workspaces {}

        TimeDate {}
    }
}
