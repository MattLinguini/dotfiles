import QtQuick
import Quickshell.Io
import "../../config"

Rectangle {
    id: root
    
    // Properties
    property int indicatorSize: 64
    property int indicatorHeight: 24
    property int smallRadius: 6
    property int smallMargin: 2
    property int brightnessLevel: 25
    
    // Visual properties
    width: indicatorSize
    height: indicatorHeight
    radius: smallRadius
    color: Colors.surfaceContainerHigh
    border.color: Colors.outlineVariant
    border.width: 1

    // Brightness level bar
    Rectangle {
        id: brightnessLevelBar
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
            margins: root.smallMargin
        }
        width: (root.brightnessLevel / 100) * (root.width - 4)
        radius: 2
        color: Colors.warning
    }

    // Brightness percentage text
    Text {
        anchors.centerIn: parent
        text: root.brightnessLevel + "%"
        color: Colors.backgroundTextColor
        font.pixelSize: 10
        font.family: "Inter, sans-serif"
        font.bold: true
    }

    // Brightness icon
    Text {
        anchors {
            right: parent.right
            top: parent.top
            margins: root.smallMargin
        }
        text: "☀"
        color: Colors.warning
        font.pixelSize: 8
    }

    // Click to cycle brightness levels
    MouseArea {
        anchors.fill: parent
        onClicked: cycleBrightness()
    }

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
