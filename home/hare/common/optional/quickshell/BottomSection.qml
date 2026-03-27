import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import qs.shared
import qs.modules

Rectangle {
    Layout.fillWidth: true
    color: "transparent"

    ColumnLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        spacing: 5

        // Weather {}
        Volume {}
        Cpu {}
        Mem {}
        Disk {}
    }
}
