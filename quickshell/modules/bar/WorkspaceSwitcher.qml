import QtQuick
import Quickshell.Hyprland
import "../../config"

Row {
    id: root
    
    // Properties
    property int workspaceButtonSize: 32
    property int workspaceButtonHeight: 24
    property int smallRadius: 6
    property int smallSpacing: 6
    property int margin: 12
    
    // Layout properties
    spacing: smallSpacing
    
    Repeater {
        model: Hyprland.workspaces

        Rectangle {
            width: root.workspaceButtonSize
            height: root.workspaceButtonHeight
            radius: root.smallRadius
            color: modelData.active ? Colors.primary : Colors.surfaceContainerHigh
            border.color: modelData.active ? Colors.primaryLight : Colors.outlineVariant
            border.width: 1

            // Hover effect
            Behavior on color {
                ColorAnimation { duration: 150 }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onClicked: Hyprland.dispatch("workspaces " + modelData.id)
                
                onEntered: {
                    if (!modelData.active) {
                        parent.color = Colors.surfaceContainerHighest
                    }
                }
                onExited: {
                    if (!modelData.active) {
                        parent.color = Colors.surfaceContainerHigh
                    }
                }
            }

            Text {
                text: modelData.id
                anchors.centerIn: parent
                color: Colors.surfaceVariantTextColor
                font.pixelSize: 12
                font.family: "Inter, sans-serif"
                font.weight: modelData.active ? Font.Bold : Font.Normal
            }
        }
    }
    
    // Error state
    Text {
        visible: Hyprland.workspaces.length === 0
        text: "Error: No Workspaces"
        color: Colors.error
        font.pixelSize: 12
        font.family: "Inter, sans-serif"
    }
}
