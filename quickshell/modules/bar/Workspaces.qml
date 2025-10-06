import QtQuick
import Quickshell.Hyprland
import "../../config"

Item {
    id: root
    readonly property int spacingSmall: 10
    readonly property int backgroundRadius: 12
    readonly property int backgroundPadding: 10
    
    readonly property int activeWorkspaceButtonWidth: 25
    readonly property int workspaceButtonWidth: 12
    readonly property int workspaceButtonHeight: 12
    readonly property int smallRadius: 10
    
    // Calcuates the active workspace id from Hyprland.
    readonly property int activeWorkspaceId: {
        if (!(Hyprland.workspaces && Hyprland.workspaces.values)) return -1
        for (var i = 0; i < Hyprland.workspaces.values.length; i++) {
            var ws = Hyprland.workspaces.values[i]
            if (ws && ws.active === true) {
                var v = parseInt(ws.id, 10)
                return isNaN(v) ? -1 : v
            }
        }
        return -1
    }

    readonly property var occupiedIds: (function() {
        var out = []
        if (Hyprland.workspaces && Hyprland.workspaces.values) {
            for (var i = 0; i < Hyprland.workspaces.values.length; i++) {
                var ws = Hyprland.workspaces.values[i]
                if (!ws) continue
                var v = parseInt(ws.id, 10)
                if (!isNaN(v)) out.push(v)
            }
        }
        return out
    })()

    function isWorkspaceOccupied(id) {
        for (var i = 0; i < root.occupiedIds.length; i++) {
            if (root.occupiedIds[i] === id) return true
        }
        return false
    }

    // Derived size
    implicitWidth: row.implicitWidth + backgroundPadding * 2
    implicitHeight: row.implicitHeight + backgroundPadding * 2

    // Background slightly lighter than the bar
    Rectangle {
        id: bg
        anchors.fill: parent
        radius: backgroundRadius
        color: Colors.surfaceContainerHigh
    }

    Row {
        id: row
        spacing: root.spacingSmall
        anchors.fill: parent
        anchors.margins: backgroundPadding

        Repeater {
            model: 10 // Hyprland has 10 workspaces.

            Rectangle {
                property int wsId: index + 1
                property bool isActive: root.activeWorkspaceId === wsId
                property bool isOccupied: root.isWorkspaceOccupied(wsId)
                property bool hovered: false

                width: isActive ? root.activeWorkspaceButtonWidth : root.workspaceButtonWidth
                height: root.workspaceButtonHeight
                radius: root.smallRadius
                color: isActive
                    ? Colors.surfaceTextColor
                    : (hovered
                        ? Colors.surfaceContainerHighest
                        : (isOccupied ? Colors.surfaceTextColor : Colors.surfaceVariant))

                // Smooth transitions
                Behavior on color { ColorAnimation { duration: 150 } }
                Behavior on width { NumberAnimation { duration: 120; easing.type: Easing.OutCubic } }
            }
        }
    }
}



