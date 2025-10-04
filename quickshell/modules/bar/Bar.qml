pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Shapes
import Quickshell
import Quickshell.Hyprland
import "../../services"
import "../../config"
import "VolumeIndicator"
import "BrightnessIndicator"
import "TimeDisplay"
import "WorkspaceSwitcher"
import "WindowInfo"

PanelWindow {
  id: root
  
  // Properties
  property color mColor: Colors.surface
  property int barHeight: 52
  property int indicatorSize: 64
  property int indicatorHeight: 24
  property int workspaceButtonSize: 32
  property int workspaceButtonHeight: 24
  property int cornerRadius: 30
  property int smallRadius: 6
  property int margin: 12
  property int smallMargin: 2
  property int spacing: 12
  property int smallSpacing: 6

  // Window configuration
  color: "transparent"
  exclusionMode: ExclusionMode.Normal
  mask: Region {}
  screen: root.screen
  exclusiveZone: root.barHeight

  anchors {
    left: true
    top: true
    right: true
  }

  // Main bar container
  Rectangle {
    id: top
    implicitWidth: QsWindow.window.width
    implicitHeight: root.barHeight
    color: root.mColor

    // Center - Workspace Switcher
    WorkspaceSwitcher {
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
      BatteryIndicator {}

      // Time Display
      TimeDisplay {}
    }
  }

  // Left rounded corner for top border
  Corner {
    x: 0
    y: top.implicitHeight
    rotation: 0
  }

  // Right rounded corner for top border
  Corner {
    x: QsWindow.window.width - radius
    y: top.implicitHeight
    rotation: 90
  }

  // Reusable corner component
  component Corner: Shape {
    id: corner
    preferredRendererType: Shape.CurveRenderer

    property real radius: root.cornerRadius

    ShapePath {
      strokeWidth: 0
      fillColor: root.mColor

      startX: corner.radius

      PathArc {
        relativeX: -corner.radius
        relativeY: corner.radius
        radiusX: corner.radius
        radiusY: corner.radius
        direction: PathArc.Counterclockwise
      }

      PathLine {
        relativeX: 0
        relativeY: -corner.radius
      }

      PathLine {
        relativeX: corner.radius
        relativeY: 0
      }
    }
  }

}