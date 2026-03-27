import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.shared
import qs.services

Rectangle {
    Layout.alignment: Qt.AlignHCenter
    width: 38
    height: 78
    radius: 0

    color: Colors.bgDarker
    border.width: 1
    border.color: Colors.border

    Component.onCompleted: SystemUsage.refCount++
    Component.onDestruction: SystemUsage.refCount--

    Rectangle {
        id: indicatorTrack
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 3
        anchors.leftMargin: 3
        anchors.rightMargin: 3

        height: 2
        color: "transparent"

        Rectangle {
            id: usageIndicator
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            width: Math.max(2, parent.width * Math.min(SystemUsage.cpuPerc, 1.0))

            color: Colors.accent

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

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 5

        Text {
            Layout.alignment: Qt.AlignHCenter
            // anchors.horizontalCenter: parent.horizontalCenter
            text: "󰍛"
            font.family: Config.icon
            font.pixelSize: 20
            color: Colors.fg
        }

        Text {
            Layout.alignment: Qt.AlignHCenter
            text: Math.round(SystemUsage.cpuPerc * 100) + ""
            font.pixelSize: 16
            font.family: Config.font
            color: Colors.fg
        }
    }
}
