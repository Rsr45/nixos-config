import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.shared
import qs.services

Rectangle {
    id: root

    Layout.alignment: Qt.AlignVCenter

    implicitHeight: 20
    implicitWidth: content.implicitWidth + 16

    radius: 0
    color: Colors.bg
    border.width: 0
    border.color: Colors.border

    Component.onCompleted: SystemUsage.refCount++
    Component.onDestruction: SystemUsage.refCount--

    readonly property real warnThreshold: 0.90
    readonly property bool isHot: SystemUsage.storagePerc >= warnThreshold

    // ───── Bottom indicator line ─────
    Rectangle {
        id: indicatorTrack

        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 3
        anchors.rightMargin: 3
        anchors.topMargin: 2

        height: 2
        color: Colors.bgAlt

        Rectangle {
            id: usageIndicator

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            width: parent.width * Math.min(SystemUsage.storagePerc, 1.0)

            color: root.isHot ? "#ff5555" : Colors.accent

            Behavior on width {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.OutCubic
                }
            }

            Behavior on color {
                ColorAnimation {
                    duration: 150
                }
            }
        }
    }

    // ───── Content (horizontal layout) ─────
    RowLayout {
        id: content

        anchors.centerIn: parent
        spacing: 6

        // Text {
        //     text: "󰋊"
        //     font.family: Config.icon
        //     font.pixelSize: 14
        //     color: root.isHot ? "#ff5555" : Colors.fg
        // }

        Text {
	    text: "SSD: " + SystemUsage.storageFree + "GiB/"
	    + SystemUsage.storageUsed + "GiB -> "
	    + SystemUsage.storageTotal + "GiB"
            font.family: Config.font
            font.pixelSize: 16
            color: root.isHot ? "#ff5555" : Colors.fg
        }
    }
}
