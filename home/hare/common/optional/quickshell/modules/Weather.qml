import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import qs.shared

Rectangle {
    Layout.alignment: Qt.AlignHCenter
    width: 38
    height: 78
    radius: 0

    color: Colors.bgDarker
    border.width: 1
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
                    const data = JSON.parse(out);
                    // Your script returns: { "text": "  <span>11.8°C</span>", ... }
                    const tempMatch = data.text.match(/([\d.]+)°C/);
                    const match = data.text.match(/([\uE000-\uF8FF])\s*<span>(-?[\d.]+)°C<\/span>/);
                    if (match)
                        icon = match[1];
                    temperature = parseFloat(match[2]);
                } catch (e) {
                    temperature = 0;
                    icon = "";
                }
            }
        }
    }

    Timer {
        interval: 900000  // 15 minutes
        running: true
        repeat: true
        onTriggered: weatherProcess.running = true
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 5

        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            // Layout.topMargin: 4
            // Layout.leftMargin: 5
            height: 20
            Text {
                anchors.centerIn: parent
                text: `${icon}`
                color: Colors.fg
                font.family: Config.icon
                font.pixelSize: 22
            }
        }
        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            // Layout.leftMargin: 5
            // Layout.bottomMargin: 4
            height: 20
            Text {
                anchors.centerIn: parent
                text: `${temperature}`
                color: Colors.fg
                font.family: Config.font
                font.pixelSize: 16
            }
        }
    }
}
