import QtQuick
import "../../services"
import "../../config"

Rectangle {
    id: batteryContainer
    width: 64
    height: 24
    radius: 6
    color: Colors.surfaceContainerHigh
    border.color: Colors.outlineVariant
    border.width: 1
    visible: BatteryService.hasBattery

    // Battery level bar
    Rectangle {
        id: batteryLevelBar
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
            margins: 2
        }
                    width: (BatteryService.batteryLevel * 100 / 100) * (batteryContainer.width - 4)
                    radius: 2
                    color: {
                        if (BatteryService.batteryLevel > 0.5) return Colors.success
                        if (BatteryService.batteryLevel > 0.2) return Colors.warning
                        return Colors.error
                    }
    }

    // Battery percentage text
    Text {
        anchors.centerIn: parent
        text: Math.round(BatteryService.batteryLevel * 100) + "%"
        color: Colors.backgroundTextColor
        font.pixelSize: 10
        font.family: "Inter, sans-serif"
        font.bold: true
    }

    // Charging indicator
    Text {
        anchors {
            right: parent.right
            top: parent.top
            margins: 2
        }
        text: "⚡"
        color: Colors.warning
        font.pixelSize: 8
        visible: BatteryService.isChargingOrFull
    }

    // Battery icon
    Text {
        anchors {
            left: parent.left
            top: parent.top
            margins: 2
        }
        text: "🔋"
        color: {
            if (BatteryService.batteryLevel > 0.5) return Colors.success
            if (BatteryService.batteryLevel > 0.2) return Colors.warning
            return Colors.error
        }
        font.pixelSize: 8
    }
}
