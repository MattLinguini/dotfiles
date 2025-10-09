import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import "../common"
import "../../services"
import "../../config"

Item {
    id: root
    width: 65
    height: 25
    visible: BatteryService.hasBattery

    readonly property color batteryColor: {
        if (BatteryService.batteryLevel < BatteryService.lowLevel) {
            return Colors.error;
        }
    
        return Colors.surfaceTextColor;
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
                icon: BatteryService.isPluggedIn ? "bolt" : "bolt"
                fill: BatteryService.isPluggedIn ? 1 : 0
                font.pixelSize: 16
                color: Colors.surfaceTextColor
            }

            Text {
                id: batteryText
                text: BatteryService.batteryLevel * 100 + "%"
                font.pixelSize: 12
                color: Colors.surfaceTextColor
                font.bold: BatteryService.isBatteryLow
            }
        }

        Rectangle {
            id: bar
            clip: true
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            width: root.width * Math.min(Math.max(BatteryService.batteryLevel, 0), 1)
            height: root.height
            color: batteryColor

            Behavior on width {
                NumberAnimation { duration: 300; easing.type: Easing.OutExpo }
            }

            RowLayout {
                id: textLayer2
                x: (root.width - width) / 2
                y: (root.height - height) / 2 - 1
                spacing: 0

                MaterialIcon {
                    icon: BatteryService.isPluggedIn ? "bolt" : "bolt"
                    fill: BatteryService.isPluggedIn ? 1 : 0
                    font.pixelSize: 16
                    color: Colors.surface
                }

                Text {
                    text: BatteryService.batteryLevel * 100 + "%"
                    font.pixelSize: 12
                    color: Colors.surface
                }
            }
        }
    }
}