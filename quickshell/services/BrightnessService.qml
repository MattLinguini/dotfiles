pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    // --- Core Brightness Properties ---
    property real brightnessLevel: 0.5
    property int brightnessPercentage: Math.round(brightnessLevel * 100)
    
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
                    const newLevel = percentage / 100.0
                    if (Math.abs(root.brightnessLevel - newLevel) > 0.01) {
                        root.brightnessLevel = newLevel
                    }
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
    
    // Function to set brightness (0.0 to 1.0)
    function setBrightness(level) {
        const percentage = Math.round(Math.max(0, Math.min(100, level * 100)))
        setBrightnessProcess.command = ["brightnessctl", "set", percentage + "%"]
        setBrightnessProcess.running = true
        // Update immediately for responsive UI
        brightnessLevel = level
    }
    
    Component.onCompleted: brightnessProcess.running = true
}
