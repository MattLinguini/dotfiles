pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import "../../config"

Rectangle {
    id: root
    
    // Properties
    property int textSize: 12
    property int programNameSize: 10
    property color textColor: Colors.surfaceTextColor
    property color programNameColor: Colors.surfaceVariantTextColor
    
    // Hyprland integration
    readonly property HyprlandMonitor monitor: Hyprland.monitorFor(root.QsWindow.window?.screen)
    readonly property Toplevel activeWindow: ToplevelManager.activeToplevel
    property bool focusingThisMonitor: HyprlandData.activeWorkspace?.monitor == monitor?.name
    property var biggestWindow: HyprlandData.biggestWindowForWorkspace(HyprlandData.monitors[root.monitor?.id]?.activeWorkspace.id)
    
    // Layout
    implicitWidth: Math.max(programNameText.implicitWidth, titleText.implicitWidth) + 20
    implicitHeight: programNameText.implicitHeight + titleText.implicitHeight + 4
    
    color: "transparent"
    
    // Program name (top)
    Text {
        id: programNameText
        text: {
            // Try different approaches to get window info
            if (root.activeWindow && root.activeWindow.activated && root.activeWindow.appId) {
                return root.activeWindow.appId
            } else {
                return "Desktop"
            }
        }
        color: root.programNameColor
        font.pixelSize: root.programNameSize
        font.family: "Inter"
        anchors {
            top: parent.top
            left: parent.left
        }
        visible: text !== ""
    }
    
    // Window title (bottom)
    Text {
        id: titleText
        text: {
            // Try different approaches to get window title
            if (root.activeWindow && root.activeWindow.activated && root.activeWindow.title) {
                return root.activeWindow.title
            } else {
                return `Workspace ${monitor?.activeWorkspace?.id ?? 1}`
            }
        }
        color: root.textColor
        font.pixelSize: root.textSize
        font.family: "Inter"
        font.weight: Font.Medium
        anchors {
            bottom: parent.bottom
            left: parent.left
        }
        visible: text !== ""
    }
}
