import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Services.UPower
import "../common"
import "../../services"
import "../../config"

Item {
    id: root
    width: 65
    height: 25
    visible: BatteryService.hasBattery

    property var low_battery_level: 15
    property string battery: visible ? (BatteryService.batteryLevel * 100) + "%" : "0%"

    property color batteryColor: {
        if (!BatteryService.isPluggedIn) {
            return Colors.success;
        }
        if (BatteryService.batteryLevel < 0.2) {
            return Colors.error;
        }
        if (BatteryService.batteryLevel < 0.5) {
            return Colors.secondary;
        }
        return Colors.success;
    }

    function isLowBattery() {
        return parseFloat(root.battery) < root.low_battery_level;
    }

    property string icon: {
        if (!BatteryService.isPluggedIn) return "bolt";
        return "";
    }

    ClippingRectangle {
        id: background
        anchors.fill: parent
        radius: 100
        color: Colors.opacify(batteryColor, 0.2)

        RowLayout {
            id: textLayer
            anchors.centerIn: parent
            spacing: 0

            MaterialIcon {
                icon: root.icon
                font.pixelSize: 16
                color: batteryColor
            }

            Text {
                id: batteryText
                text: root.battery
                font.pixelSize: 12
                color: batteryColor
                font.bold: root.isLowBattery()
            }
        }

        Rectangle {
            id: bar
            clip: true
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            width: root.width * Math.min(Math.max(parseFloat(battery), 0), 100) / 100
            height: root.height * Math.min(Math.max(parseFloat(battery), 0), 100) / 100
            color: batteryColor

            Behavior on width {
                NumberAnimation { duration: 300; easing.type: Easing.OutExpo }
            }

            RowLayout {
                id: textLayer2
                x: (root.width - width) / 2
                y: (root.height - height) / 2
                spacing: 0

                MaterialIcon {
                    icon: root.icon
                    font.pixelSize: 16
                    color: Colors.surface
                }

                Text {
                    text: root.battery
                    font.pixelSize: 12
                    color: Colors.surface
                }
            }
        }
    }
}