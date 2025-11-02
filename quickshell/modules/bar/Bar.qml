pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Shapes
import Quickshell
import Quickshell.Hyprland
import "../../services"
import "../../config"
import "../common"
import "VolumeIndicator"
import "BrightnessIndicator"
import "TimeDisplay"
import "Workspaces"
import "WindowInfo"
import "Battery"

PanelWindow {
  id: root
  
  // Properties
  property color mColor: Colors.surface
  property int barHeight: 52
  property int cornerRadius: 20
  property int margin: 12
  property int spacing: 12

  // Window configuration
  color: "transparent"
  exclusionMode: ExclusionMode.Normal
  mask: Region {}
  exclusiveZone: root.barHeight

  anchors {
    left: true
    top: true
    right: true
  }

  // Main bar container
  Rectangle {
    id: top
    width: parent.width
    height: root.barHeight
    color: root.mColor

    // Center - Workspaces
    Workspaces {
      id: workspacesRow
      anchors {
        horizontalCenter: parent.horizontalCenter
        verticalCenter: parent.verticalCenter
      }
    }

    // Left side - Window Info Display
    WindowInfo {
      id: windowInfo
      anchors {
        left: parent.left
        verticalCenter: parent.verticalCenter
        leftMargin: root.margin
      }
    }

    // Right side - System Indicators
    Row {
      id: rightSideRow
      anchors {
        right: parent.right
        verticalCenter: parent.verticalCenter
        rightMargin: root.margin
      }
      spacing: root.spacing

      // Volume Indicator
      VolumeIndicator {}

      // Brightness Indicator
      BrightnessIndicator {}

      // Battery Indicator
      Battery {}

      // Time Display
      TimeDisplay {}
    }
  }

  // Left rounded corner for top border
  Corner {
    anchors.left: parent.left
    anchors.top: top.bottom
    rotation: 0
    radius: root.cornerRadius
    fillColor: root.mColor
  }

  // Right rounded corner for top border
  Corner {
    anchors.right: parent.right
    anchors.top: top.bottom
    rotation: 90
    radius: root.cornerRadius
    fillColor: root.mColor
  }

}