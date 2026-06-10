import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import qs.shared
import qs.modules

Rectangle {
    Layout.fillWidth: true
    color: "transparent"

    RowLayout {
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        spacing: 0

	VpnNM {}
	Weather {}
	Volume {}
	Mem {}
	Disk {}
    }
}
