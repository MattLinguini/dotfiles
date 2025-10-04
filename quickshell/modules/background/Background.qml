import QtQuick
import Quickshell
import Quickshell.Wayland
import "../../config"

PanelWindow {
    id: root
    
    // Simple wallpaper configuration
    property string wallpaperPath: Config.wallpaperPath
    
    // Layer properties
    screen: root.screen || Quickshell.primaryScreen
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Bottom
    WlrLayershell.namespace: "quickshell:background"
    
    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }
    
    color: "transparent"
    
    // Simple wallpaper image
    Image {
        id: wallpaper
        anchors.fill: parent
        source: root.wallpaperPath
        fillMode: Image.PreserveAspectCrop
        smooth: true
        cache: true
        asynchronous: true
        
        // Debug information
        onStatusChanged: {
            console.log("Wallpaper status:", status)
            if (status === Image.Error) {
                console.log("Wallpaper failed to load:", source)
            } else if (status === Image.Ready) {
                console.log("Wallpaper loaded successfully:", source)
            }
        }
        
        // Fallback background color if image fails to load
        Rectangle {
            anchors.fill: parent
            color: "#1a1a1a"
            visible: wallpaper.status === Image.Error || wallpaper.status === Image.Null
        }
    }
}
