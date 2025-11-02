import QtQuick
import QtQuick.Shapes

// Reusable rounded corner shape
Shape {
  id: corner
  preferredRendererType: Shape.CurveRenderer

  property real radius: 20
  property color fillColor: "transparent"

  ShapePath {
    strokeWidth: 0
    fillColor: corner.fillColor

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


