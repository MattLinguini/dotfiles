import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell.Io
import "../common"
import "../../config"

Item {
    id: root
    width: 65
    height: 25
    
    property int brightnessLevel: 25
    readonly property color levelColor: Colors.surfaceTextColor

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
                icon: "sunny"
                font.pixelSize: 16
                color: Colors.surfaceTextColor
            }

            Text {
                text: root.brightnessLevel + "%"
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
            width: root.width * Math.min(Math.max(root.brightnessLevel / 100, 0), 1)
            height: root.height
            color: levelColor

            Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.OutExpo } }

            RowLayout {
                id: textLayer2
                x: (root.width - width) / 2
                y: (root.height - height) / 2 - 1
                spacing: 0

                MaterialIcon {
                    icon: "sunny"
                    font.pixelSize: 16
                    color: Colors.surface
                }

                Text {
                    text: root.brightnessLevel + "%"
                    font.pixelSize: 12
                    color: Colors.surface
                }
            }
        }
    }

    MouseArea { anchors.fill: parent; onClicked: cycleBrightness() }

    // Brightness level cycling logic
    function cycleBrightness() {
        const levels = [0, 25, 50, 75, 100]
        const currentIndex = levels.indexOf(brightnessLevel)
        const nextIndex = (currentIndex + 1) % levels.length
        setBrightness(levels[nextIndex])
    }

    // Process for getting current brightness
    Process {
        id: brightnessProcess
        command: ["brightnessctl", "get"]
        running: false
        stdout: StdioCollector {
            onStreamFinished: {
                const current = parseInt(text.trim())
                if (!isNaN(current)) {
                    // Convert raw brightness to percentage (assuming max is around 496)
                    const percentage = Math.round((current / 496) * 100)
                    root.brightnessLevel = percentage
                }
            }
        }
    }

    // Process for setting brightness
    Process {
        id: setBrightnessProcess
        command: ["brightnessctl", "set", "0%"]
        running: false
    }

    // Timer to periodically update brightness
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: brightnessProcess.running = true
    }

    // Function to set brightness
    function setBrightness(level) {
        setBrightnessProcess.command = ["brightnessctl", "set", level + "%"]
        setBrightnessProcess.running = true
        brightnessLevel = level
        brightnessProcess.running = true
    }

    Component.onCompleted: brightnessProcess.running = true
}
