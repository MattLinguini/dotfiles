import QtQuick
import Quickshell.Io
import QtQuick.Layouts
import Quickshell.Widgets
import "../common"
import "../../config"
import "../../services"

Item {
    id: root
    width: 65
    height: 25
    
    property int volumeLevel: Math.round(AudioService.volumeLevel * 100)
    readonly property color levelColor: Colors.surfaceTextColor
    
    // Bind to AudioService volume changes
    Connections {
        target: AudioService
        function onVolumeLevelChanged() {
            root.volumeLevel = Math.round(AudioService.volumeLevel * 100)
        }
    }

    ClippingRectangle {
        id: background
        anchors.fill: parent
        radius: 100
        color: Colors.surfaceContainerHigh

        RowLayout {
            id: textLayer
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -1
            spacing: 0

            MaterialIcon {
                icon: "volume_up"
                font.pixelSize: 16
                color: Colors.surfaceTextColor
            }

            Text {
                text: root.volumeLevel + "%"
                font.pixelSize: 12
                color: Colors.surfaceTextColor
            }
        }

        Rectangle {
            id: bar
            clip: true
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            width: root.width * Math.min(Math.max(root.volumeLevel / 100, 0), 1)
            height: root.height
            color: levelColor

            Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.OutExpo } }

            RowLayout {
                id: textLayer2
                x: (root.width - width) / 2
                y: (root.height - height) / 2 - 1
                spacing: 0

                MaterialIcon {
                    icon: "volume_up"
                    font.pixelSize: 16
                    color: Colors.surface
                }

                Text {
                    text: root.volumeLevel + "%"
                    font.pixelSize: 12
                    color: Colors.surface
                }
            }
        }
    }

    MouseArea { anchors.fill: parent; onClicked: cycleVolume() }

    // Volume level cycling logic
    function cycleVolume() {
        const levels = [0, 25, 50, 75, 100]
        const currentIndex = levels.indexOf(volumeLevel)
        const nextIndex = (currentIndex + 1) % levels.length
        setVolume(levels[nextIndex])
    }


    // Function to set volume
    function setVolume(level) {
        AudioService.setVolume(level / 100.0)
    }
}
