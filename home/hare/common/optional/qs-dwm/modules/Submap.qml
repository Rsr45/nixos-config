import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.shared

Rectangle {
    id: root

    visible: submap !== "default"

    implicitHeight: 20
    implicitWidth: label.implicitWidth + 14

    color: Colors.bgDarker
    border.width: 0
    border.color: Colors.border

    radius: 0

    property string submap: "default"

    Process {
        id: submapProc

        command: ["sh", "-c", "hyprctl submap"]

        stdout: StdioCollector {
            onStreamFinished: {
                root.submap = text.trim()
            }
        }
    }

    Timer {
        interval: 200
        running: true
        repeat: true

        onTriggered: submapProc.running = true
    }

    Text {
        id: label

        anchors.centerIn: parent

        text: root.submap.toUpperCase()

        font.family: Config.font
        font.pixelSize: 16

        color: Colors.fg
    }
}
