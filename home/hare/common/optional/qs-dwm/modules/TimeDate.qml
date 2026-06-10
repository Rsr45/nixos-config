import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import qs.shared

import QtQuick
import QtQuick.Layouts

Rectangle {
    id: clock

    color: Colors.bg
    border.width: 0
    border.color: Colors.border
    radius: 0

    // single source of truth
    property date now: new Date()

    /*
        Supported item types:

        qt     -> Qt.formatDateTime()
        unix   -> unix timestamp
        unixMs -> unix timestamp in milliseconds
        iso    -> ISO8601
        utc    -> UTC string
        human  -> locale formatted string

        Example:
        { type: "qt", value: "hh:mm:ss" }
    */
    property var items: [
        { type: "qt", value: "hh:mm" },
        { type: "sep", value: "-" },
        { type: "qt", value: "dd.MM.yyyy" },
    ]

    implicitWidth: layout.implicitWidth + 16
    implicitHeight: layout.implicitHeight

    Timer {
        interval: 1000
        running: true
        repeat: true

        onTriggered: clock.now = new Date()
    }

    function formatItem(item) {
        switch (item.type) {

        case "qt":
            return Qt.formatDateTime(clock.now, item.value)

        case "unix":
            return Math.floor(clock.now.getTime() / 1000).toString()

        case "unixMs":
            return clock.now.getTime().toString()

        case "iso":
            return clock.now.toISOString()

        case "utc":
            return clock.now.toUTCString()

        case "datecli":
            return clock.now.toLocaleString(Qt.locale())

        case "sep":
            return item.value

        default:
            return "invalid"
        }
    }

    RowLayout {
        id: layout

        anchors.centerIn: parent
        spacing: 8

        Repeater {
            model: clock.items

            delegate: Rectangle {
                required property var modelData

                color: "transparent"

                implicitWidth: textItem.implicitWidth
                implicitHeight: textItem.implicitHeight

                Text {
                    id: textItem

                    text: clock.formatItem(modelData)

                    color: Colors.fg
                    font.family: Config.font
                    font.pixelSize: 16

                    anchors.centerIn: parent
                }
            }
        }
    }
}
