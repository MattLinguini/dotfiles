import QtQuick
import QtQuick.Layouts
import "../../config"

Item {
    id: root
    
    // Properties
    property bool showDate: true
    property bool showSeconds: false
    property string dateFormat: "ddd MMM dd"
    property string timeFormat: "h:mm AP"
    
    // Layout properties
    implicitWidth: rowLayout.implicitWidth
    implicitHeight: rowLayout.implicitHeight

    RowLayout {
        id: rowLayout
        anchors.centerIn: parent
        spacing: 4

        // Time display
        Text {
            font.pixelSize: 13
            font.family: "Inter, sans-serif"
            font.weight: Font.Medium
            color: Colors.surfaceTextColor
            text: Qt.formatTime(new Date(), root.timeFormat)
        }

        // Separator dot
        Text {
            visible: root.showDate
            font.pixelSize: 10
            color: Colors.surfaceVariantTextColor
            text: "•"
        }

        // Date display
        Text {
            visible: root.showDate
            font.pixelSize: 11
            font.family: "Inter, sans-serif"
            color: Colors.surfaceVariantTextColor
            text: Qt.formatDate(new Date(), root.dateFormat)
        }
    }

    // Timer to update time
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            // Force update of time and date text
            rowLayout.children[0].text = Qt.formatTime(new Date(), root.timeFormat)
            if (root.showDate) {
                rowLayout.children[2].text = Qt.formatDate(new Date(), root.dateFormat)
            }
        }
    }
    
    // Click handlers for interactive features
    MouseArea {
        anchors.fill: parent
        onClicked: toggleSeconds()
        onDoubleClicked: toggleDate()
    }
    
    // Function to toggle seconds display
    function toggleSeconds() {
        showSeconds = !showSeconds
        timeFormat = showSeconds ? "h:mm:ss AP" : "h:mm AP"
    }
    
    // Function to toggle date display
    function toggleDate() {
        showDate = !showDate
    }
}
