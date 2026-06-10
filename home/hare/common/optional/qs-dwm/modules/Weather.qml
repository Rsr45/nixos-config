import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import qs.shared

Rectangle {
    id: root

    Layout.alignment: Qt.AlignVCenter

    implicitHeight: 20
    implicitWidth: content.implicitWidth + 16

    radius: 0

    color: Colors.bgAlt
    border.width: 0
    border.color: Colors.border

    property real temperature: 0
    property string icon: ""

    Process {
        id: weatherProcess

        running: true
        command: ["sh", "-c", "$HOME/.config/waybar/scripts/weather.py"]

        stdout: SplitParser {
            onRead: out => {
                try {
                    const data = JSON.parse(out)

                    const match = data.text.match(
                        /([\uE000-\uF8FF])\s*<span>(-?[\d.]+)°C<\/span>/
                    )

                    if (match) {
                        icon = match[1]
                        temperature = parseFloat(match[2])
                    }
                } catch (e) {
                    temperature = 0
                    icon = ""
                }
            }
        }
    }

    Timer {
        interval: 900000
        running: true
        repeat: true

        onTriggered: weatherProcess.running = true
    }

    RowLayout {
        id: content

        anchors.centerIn: parent
        spacing: 6

        Text {
            text: icon
            color: Colors.fg
            font.family: Config.icon
            font.pixelSize: 16
        }

        Text {
            text: `${temperature}°C`
            color: Colors.fg
            font.family: Config.font
            font.pixelSize: 16
        }
    }
}
