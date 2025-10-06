import QtQuick
import Quickshell
import Quickshell.Wayland
import "../../config"

PanelWindow {
    id: root
    
    readonly property string wallpaperPath: Config.wallpaperPath

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
    
    Image {
        id: wallpaper
        anchors.fill: parent
        source: root.wallpaperPath
        fillMode: Image.PreserveAspectCrop
        smooth: true
        cache: true

        // Decode at window size (clamped) to avoid oversized textures and 0x0 thrash on startup
        sourceSize.width: Math.max(1, parent.width)
        sourceSize.height: Math.max(1, parent.height)

        asynchronous: true
        
        // If image fails to load, fallback to solid color
        Rectangle {
            anchors.fill: parent
            color: "#1a1a1a"
            visible: wallpaper.status === Image.Error || wallpaper.status === Image.Null
        }
    }
}
