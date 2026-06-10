import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import qs.shared

Rectangle {
    id: root

    implicitHeight: 20
    implicitWidth: content.implicitWidth + 16

    color: Colors.bgAlt

    property var window: Hyprland.activeToplevel
    property string title: window?.title ?? ""

    function formatTitle(t) {
        if (!t || t.length === 0)
            return "Desktop"
        return t.length > 60 ? t.slice(0, 60) + "…" : t
    }

    RowLayout {
        id: content
        anchors.centerIn: parent
        spacing: 6

        Text {
            text: formatTitle(root.title)

            font.family: Config.font
            font.pixelSize: 16
            color: Colors.fg
            elide: Text.ElideRight
        }
    }
}
