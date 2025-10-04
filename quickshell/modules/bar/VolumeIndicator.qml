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
    property int volumeLevel: 100
    
    // Visual properties
    width: indicatorSize
    height: indicatorHeight
    radius: smallRadius
    color: Colors.surfaceContainerHigh
    border.color: Colors.outlineVariant
    border.width: 1

    // Volume level bar
    Rectangle {
        id: volumeLevelBar
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
            margins: root.smallMargin
        }
        width: (root.volumeLevel / 100) * (root.width - 4)
        radius: 2
        color: Colors.primary
    }

    // Volume percentage text
    Text {
        anchors.centerIn: parent
        text: root.volumeLevel + "%"
        color: Colors.backgroundTextColor
        font.pixelSize: 10
        font.family: "Inter, sans-serif"
        font.bold: true
    }

    // Volume icon
    Text {
        anchors {
            right: parent.right
            top: parent.top
            margins: root.smallMargin
        }
        text: "🔊"
        color: Colors.primary
        font.pixelSize: 8
    }

    // Click to cycle volume levels
    MouseArea {
        anchors.fill: parent
        onClicked: cycleVolume()
    }

    // Volume level cycling logic
    function cycleVolume() {
        const levels = [0, 25, 50, 75, 100]
        const currentIndex = levels.indexOf(volumeLevel)
        const nextIndex = (currentIndex + 1) % levels.length
        setVolume(levels[nextIndex])
    }

    // Process for getting current volume
    Process {
        id: volumeProcess
        command: ["pactl", "get-sink-volume", "@DEFAULT_SINK@"]
        running: false
        stdout: StdioCollector {
            onStreamFinished: {
                const output = text.trim()
                const matches = output.match(/(\d+)%/)
                if (matches && matches.length > 1) {
                    const level = parseInt(matches[1])
                    if (!isNaN(level)) {
                        root.volumeLevel = level
                    }
                }
            }
        }
    }

    // Process for setting volume
    Process {
        id: setVolumeProcess
        command: ["pactl", "set-sink-volume", "@DEFAULT_SINK@", "0%"]
        running: false
    }

    // Timer to periodically update volume
    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: volumeProcess.running = true
    }

    // Function to set volume
    function setVolume(level) {
        setVolumeProcess.command = ["pactl", "set-sink-volume", "@DEFAULT_SINK@", level + "%"]
        setVolumeProcess.running = true
        volumeLevel = level
        volumeProcess.running = true
    }

    Component.onCompleted: volumeProcess.running = true
}
