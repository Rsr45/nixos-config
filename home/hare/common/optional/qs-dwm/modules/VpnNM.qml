import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.shared

Rectangle {
    id: root

    implicitHeight: 20
    implicitWidth: content.implicitWidth + 16

    color: Colors.bgAlt
    border.width: 0

    property string vpnText: ""

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: vpnProc.running = true
    }

    Process {
        id: vpnProc
        command: ["bash", "-c", "$HOME/.config/waybar/scripts/wbm_vpn wg-NO-FREE-10"]
        running: false

        stdout: SplitParser {
            onRead: data => {
                try {
                    const obj = JSON.parse(data.trim());
                    vpnText = obj.text ?? "";
                } catch (e) {
                    vpnText = data.trim(); // fallback
                }
            }
        }
    }

    RowLayout {
        id: content
        anchors.centerIn: parent
        spacing: 6

        Text {
            text: vpnText
            font.family: Config.font
            font.pixelSize: 16
            color: Colors.fg
        }
    }
}
