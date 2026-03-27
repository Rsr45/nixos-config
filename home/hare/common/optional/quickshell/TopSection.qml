import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.shared
import qs.modules

Rectangle {
    Layout.fillWidth: true
    color: "transparent"

    ColumnLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        spacing: 5

        WorkspacesNerd {}
        // WorkspacesRumda {}
    }
}
