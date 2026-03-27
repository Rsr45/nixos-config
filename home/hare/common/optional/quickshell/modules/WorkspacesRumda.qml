import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import qs.shared

Rectangle {
    id: root

    readonly property int moduleWidth: 38
    readonly property int moduleRadius: 0
    readonly property int moduleBorderWidth: 1
    readonly property int workspaceSpacing: 3
    readonly property int workspaceInnerSpacing: -3
    readonly property int workspaceWidth: 12
    readonly property int workspaceActiveHeight: 34
    readonly property int workspaceInactiveHeight: 19
    readonly property int workspaceShapeWidth: 8

    Layout.alignment: Qt.AlignHCenter
    implicitHeight: childrenRect.height + 19
    width: moduleWidth
    radius: moduleRadius
    color: Colors.bgDarker
    border.width: moduleBorderWidth
    border.color: Colors.border

    // Workspace container
    ColumnLayout {
        anchors.centerIn: parent
        spacing: workspaceSpacing

        ColumnLayout {
            spacing: workspaceInnerSpacing

            Repeater {
                model: Hyprland.workspaces

                delegate: Item {
                    id: workspaceItem
                    required property var modelData
                    property bool hovered: false

                    width: root.workspaceWidth
                    Layout.preferredHeight: modelData.active ? root.workspaceActiveHeight : root.workspaceInactiveHeight
                    Layout.alignment: Qt.AlignHCenter

                    // Workspace indicator shape
                    Shape {
                        id: workspaceShape
                        anchors.centerIn: parent
                        width: root.workspaceShapeWidth
                        height: parent.height
                        antialiasing: true
                        smooth: true
                        layer.enabled: true
                        layer.samples: 8

                        ShapePath {
                            fillColor: (workspaceItem.modelData.active || workspaceItem.hovered) ? Colors.accent : Colors.accentDarker
                            strokeColor: "transparent"
                            strokeWidth: 0

                            // Define parallelogram shape with rounded corners
                            startX: 1
                            startY: 8

                            // Top edge - slanted up-right
                            PathLine {
                                x: 7
                                y: 2
                            }
                            PathArc {
                                x: 8
                                y: 3
                                radiusX: 2
                                radiusY: 2
                            }

                            // Right edge
                            PathLine {
                                x: 8
                                y: workspaceShape.height - 10
                            }
                            PathArc {
                                x: 7
                                y: workspaceShape.height - 8
                                radiusX: 2
                                radiusY: 2
                            }

                            // Bottom edge - slanted down-left
                            PathLine {
                                x: 1
                                y: workspaceShape.height - 2
                            }
                            PathArc {
                                x: 0
                                y: workspaceShape.height - 3
                                radiusX: 2
                                radiusY: 2
                            }

                            // Left edge
                            PathLine {
                                x: 0
                                y: 10
                            }
                            PathArc {
                                x: 1
                                y: 8
                                radiusX: 2
                                radiusY: 2
                            }
                        }

                        Behavior on height {
                            NumberAnimation {
                                duration: 200
                                easing.type: Easing.OutQuart
                            }
                        }
                    }

                    // Interaction area
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true

                        onEntered: workspaceItem.hovered = true
                        onExited: workspaceItem.hovered = false

                        onClicked: {
                            // switch to the clicked workspace
                            Hyprland.dispatch("workspace " + workspaceItem.modelData.id);
                        }
                        onWheel: wheel => {
                            const direction = wheel.angleDelta.y > 0 ? "-1" : "+1";
                            Hyprland.dispatch("workspace e" + direction);  // e+1 or e-1 for relative workspace switching
                        }
                    }
                }
            }
        }
    }
}
