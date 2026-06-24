import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.shared
import qs.modules

Rectangle {
    Layout.fillWidth: true
    color: "transparent"

    RowLayout {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.topMargin: 10
        spacing: 0

	TimeDate {}
        Workspaces {}
        Window {}
        // Submap {}
        SysTray {}
    }
}
