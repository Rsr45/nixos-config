import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import qs.shared

Rectangle {
    id: timeDateModule

    property string currentTime: Qt.formatDateTime(new Date(), "hh:mm")
    property string currentHours: Qt.formatDateTime(new Date(), "hh")
    property string currentMinutes: Qt.formatDateTime(new Date(), "mm")
    property string currentDay: Qt.formatDateTime(new Date(), "dd")
    property string currentMonth: Qt.formatDateTime(new Date(), "MM")

    width: 38
    color: Colors.bgDarker
    // color: Qt.alpha(Colors.bg, 0.50)
    radius: 0
    border.width: 1
    border.color: Colors.border
    Layout.preferredHeight: 100   // adjust as needed for both time + date

    // Update time/date every second
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            currentTime = Qt.formatDateTime(new Date(), "hh:mm");
            currentHours = Qt.formatDateTime(new Date(), "hh");
            currentMinutes = Qt.formatDateTime(new Date(), "mm");
            currentDay = Qt.formatDateTime(new Date(), "dd");
            currentMonth = Qt.formatDateTime(new Date(), "MM");
        }
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 8

        // Clock
        ColumnLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 0

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: currentHours
                color: Colors.foregroundColor
                font.family: Config.font
                font.pixelSize: 16
            }
            Text {
                Layout.alignment: Qt.AlignHCenter
                text: currentMinutes
                color: Colors.foregroundColor
                font.family: Config.font
                font.pixelSize: 16
            }
        }

        // Date
        ColumnLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 0

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: currentDay
                color: Colors.foregroundColor
                font.family: Config.font
                font.pixelSize: 16
            }
            Text {
                Layout.alignment: Qt.AlignHCenter
                text: currentMonth
                color: Colors.foregroundColor
                font.family: Config.font
                font.pixelSize: 16
            }
        }
    }
}
