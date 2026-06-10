import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.modules

Rectangle {
    Layout.fillHeight: true
    Layout.fillWidth: true
    color: "transparent"

    RowLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        Layout.fillHeight: true
        Layout.fillWidth: true
        spacing: 0
        x: (bar.width - width) / 12

    }
}
