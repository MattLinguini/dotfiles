//@pragma UseQApplication

import "./modules/bar"
import "./modules/background"

import QtQuick
import Quickshell

ShellRoot {
  SystemPalette {
    id: palette
    colorGroup: SystemPalette.Active
  }

  Variants {
    model: Quickshell.screens
    delegate: Scope {
      id: root
      required property var modelData

      Bar {
        screen: root.modelData
      }

      Background {
        screen: root.modelData
      }


    }
  }
}