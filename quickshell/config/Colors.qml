pragma Singleton

import QtQuick

QtObject {
    // Material Design Color Palette - Dark Theme
    
    // Primary Colors (Material Blue)
    readonly property color primary: "#2196F3"           // Material Blue 500
    readonly property color primaryLight: "#64B5F6"      // Material Blue 300
    readonly property color primaryDark: "#1976D2"       // Material Blue 700
    readonly property color primaryVariant: "#1565C0"    // Material Blue 800
    
    // Secondary Colors (Material Teal)
    readonly property color secondary: "#009688"         // Material Teal 500
    readonly property color secondaryLight: "#4DB6AC"    // Material Teal 300
    readonly property color secondaryDark: "#00695C"     // Material Teal 700
    
    // Surface Colors (Material Dark Theme)
    readonly property color surface: "#121212"           // Material Dark Surface
    readonly property color surfaceVariant: "#1E1E1E"    // Material Dark Surface Variant
    readonly property color surfaceContainer: "#1C1B1E"  // Material Dark Surface Container
    readonly property color surfaceContainerHigh: "#2B2930" // Material Dark Surface Container High
    readonly property color surfaceContainerHighest: "#36343B" // Material Dark Surface Container Highest
    
    // Background Colors
    readonly property color background: "#0F0F0F"        // Material Dark Background
    readonly property color backgroundSecondary: "#1A1A1A" // Slightly lighter background
    readonly property color backgroundTertiary: "#2A2A2A" // Even lighter background
    
    // On-Surface Colors (Text on surfaces)
    readonly property color surfaceTextColor: "#E1E1E1"    // Material Dark On Surface
    readonly property color surfaceVariantTextColor: "#C4C7C5"  // Material Dark On Surface Variant
    readonly property color backgroundTextColor: "#FFFFFF" // Material Dark On Background
    
    // Error Colors
    readonly property color error: "#CF6679"             // Material Dark Error
    readonly property color errorTextColor: "#000000"    // Material Dark On Error
    
    // Success Colors
    readonly property color success: "#4CAF50"           // Material Green 500
    readonly property color successTextColor: "#FFFFFF"  // White on success
    
    // Warning Colors
    readonly property color warning: "#FF9800"           // Material Orange 500
    readonly property color warningTextColor: "#000000"  // Black on warning
    
    // Info Colors
    readonly property color infoColor: "#2196F3"         // Material Blue 500
    readonly property color infoTextColor: "#FFFFFF"     // White on info
    
    // Outline Colors
    readonly property color outline: "#938F99"           // Material Dark Outline
    readonly property color outlineVariant: "#49454F"    // Material Dark Outline Variant
    
    // Shadow Colors
    readonly property color shadow: "#000000"            // Pure black shadow
    readonly property color scrim: "#000000"             // Material Dark Scrim
    
    // Transparent Colors
    readonly property color transparent: "transparent"
    readonly property color semiTransparent: "#80000000"
}
