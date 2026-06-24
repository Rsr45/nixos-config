import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Pipewire
import qs.shared

Rectangle {
    id: root

    Layout.alignment: Qt.AlignVCenter

    implicitHeight: 20
    implicitWidth: content.implicitWidth + 16

    radius: 0
    color: Colors.bg
    border.width: 0
    border.color: Colors.border

    readonly property PwNode sink: Pipewire.defaultAudioSink

    property bool muted: sink?.audio?.muted ?? false
    property real volume: sink?.audio?.volume ?? 0.0
    readonly property real visualVolume: Math.max(0, Math.min(volume, 1.0))
    property real lastVolume: volume

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    // ───── Bottom volume indicator ─────
    Rectangle {
        id: volumeTrack

        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        anchors.leftMargin: 3
        anchors.rightMargin: 3
        anchors.topMargin: 2

        height: 2
        color: Colors.bgAlt

        Rectangle {
            id: volumeIndicator

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            width: volumeTrack.width * visualVolume

            color: muted ? Colors.borderColor : Colors.accent

            Behavior on width {
                NumberAnimation {
                    duration: 140
                    easing.type: Easing.OutCubic
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
        //     text: muted ? "󰖁" : "󰕾"
        //     font.family: Config.icon
        //     font.pixelSize: 16
        //     color: Colors.fg
        //     opacity: muted ? 0.6 : 1.0
        // }

        Text {
            text: "VOL: " + Math.round(volume * 100)
            font.family: Config.font
            font.pixelSize: 16
            color: Colors.fg
            opacity: muted ? 0.6 : 1.0
        }
    }

    // ───── Interaction ─────
    MouseArea {
        anchors.fill: parent

        onClicked: {
            if (sink)
                sink.audio.muted = !muted;
        }

        onWheel: wheel => {
            if (!sink || muted)
                return;
            let delta = wheel.angleDelta.y > 0 ? 0.05 : -0.05;
            let v = Math.max(0, Math.min(1, volume + delta));
            sink.audio.volume = v;
        }
    }

    // ───── subtle feedback ─────
    onVolumeChanged: {
        if (Math.abs(volume - lastVolume) > 0.01) {
            volumeIndicator.opacity = 0.6;
            volumeIndicator.opacity = 1.0;
            lastVolume = volume;
        }
    }
}
