import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Pipewire
import qs.shared

Rectangle {
    Layout.alignment: Qt.AlignHCenter
    width: 38
    height: 78
    radius: 0

    color: Colors.bgDarker
    border.width: 1
    border.color: Colors.border

    readonly property PwNode sink: Pipewire.defaultAudioSink

    property bool muted: sink?.audio?.muted ?? false
    property real volume: sink?.audio?.volume ?? 0.0
    readonly property real visualVolume: Math.max(0, Math.min(volume, 1.0))
    property real lastVolume: volume

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    /* ───────── Top green volume indicator ───────── */
    Rectangle {
        id: volumeIndicator
        height: 2
        // width: Math.max(2, (parent.width - 6) * volume)
        width: Math.max(2, (parent.width - 6) * visualVolume)

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 3
        anchors.leftMargin: 3
        anchors.rightMargin: 3

        color: muted ? Colors.borderColor : Colors.accent2Color

        Behavior on width {
            NumberAnimation {
                duration: 140
                easing.type: Easing.OutCubic
            }
        }
    }

    /* ───────── Layout content ───────── */
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 5

        /* ─── Icon ─── */
        Text {
            Layout.alignment: Qt.AlignHCenter

            text: muted ? "󰖁" : "󰕾"
            font.family: Config.icon
            font.pixelSize: 16
            color: Colors.fg
            opacity: muted ? 0.6 : 1.0
        }

        /* ─── Percentage text (reliable) ─── */
        Text {
            Layout.alignment: Qt.AlignHCenter

            // same technique Waybar & QS use
            text: Math.round(volume * 100)
            font.family: Config.font
            font.pixelSize: 16
            color: Colors.fg
        }
    }

    /* ───────── Optional subtle feedback on change ───────── */
    onVolumeChanged: {
        if (Math.abs(volume - lastVolume) > 0.01) {
            volumeIndicator.opacity = 0.6;
            volumeIndicator.opacity = 1.0;
            lastVolume = volume;
        }
    }

    /* ───────── Interaction ───────── */
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
}
