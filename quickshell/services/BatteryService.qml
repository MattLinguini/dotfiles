pragma Singleton

import Quickshell
import Quickshell.Services.UPower

Singleton {
    // --- Core Battery Properties ---
    readonly property var device: UPower.displayDevice                   // Alias for brevity; may be null depending on platform.
    readonly property bool hasBattery: device?.isLaptopBattery ?? false  // True if a laptop battery is the display device, indicating we can monitor it.
    readonly property var batteryState: device?.state                    // The current state from UPower (e.g., Charging, Discharging, etc.).
    readonly property real batteryLevel: device?.percentage ?? 1.0       // The battery charge level, represented as a value from 0.0 to 1.0.
    readonly property real powerRate: device?.changeRate ?? 0.0          // The rate of charge/discharge, typically in Watts. Negative when discharging.
    readonly property real timeToEmpty: device?.timeToEmpty ?? 0         // Estimated time in seconds until the battery is fully empty.
    readonly property real timeToFull: device?.timeToFull ?? 0           // Estimated time in seconds until the battery is fully charged.

    // --- Derived State Properties ---
    readonly property bool isChargingOrFull: batteryState == UPowerDeviceState.Charging || batteryState == UPowerDeviceState.FullyCharged // True if the device is actively charging or is already fully charged.
    readonly property bool isPluggedIn: isChargingOrFull || batteryState == UPowerDeviceState.PendingCharge                               // True if the AC adapter is plugged in. This includes charging, full, and pending states.

    // --- Threshold Properties ---
    readonly property real lowLevel: 0.20                  // Low threshold (20%).
    readonly property real criticalLevel: 0.10             // Critical threshold (10%).
    readonly property real suspendLevel: 0.03              // Suspend threshold (3%).
    readonly property bool allowAutomaticSuspend: true     // A master switch to enable or disable the automatic suspend feature.
    readonly property bool isBatteryLow: hasBattery && (batteryLevel <= lowLevel)             // True if the battery level is at or below the "low" threshold.
    readonly property bool isBatteryCritical: hasBattery && (batteryLevel <= criticalLevel)   // True if the battery level is at or below the "critical" threshold.
    readonly property bool isAtSuspendThreshold: hasBattery && (batteryLevel <= suspendLevel) // True if the battery level is at or below the threshold that should trigger a suspend.

    // --- Combined State Properties for Actions ---
    readonly property bool isBatteryLowAndDischarging: isBatteryLow && !isPluggedIn             // True if the battery is low AND the device is not plugged in (i.e., discharging).
    readonly property bool isBatteryCriticalAndDischarging: isBatteryCritical && !isPluggedIn   // True if the battery is critical AND the device is not plugged in.
    readonly property bool shouldInitiateSuspend: allowAutomaticSuspend && isAtSuspendThreshold && !isPluggedIn // True if conditions are met to automatically suspend the system.

    // --- Actions and Notifications ---
    onIsBatteryLowAndDischargingChanged: {
        if (hasBattery && isBatteryLowAndDischarging) {
            Quickshell.execDetached([
                "notify-send", 
                "Low battery", 
                "Laptop battery low (" + Math.round(batteryLevel * 100) + "%) Consider plugging in your device.",
                "-u", "critical",
                "-a", "Shell"
            ])
        }
    }

    onIsBatteryCriticalAndDischargingChanged: {
        if (hasBattery && isBatteryCriticalAndDischarging) {
            Quickshell.execDetached([
                "notify-send", 
                "Critically low battery", 
                "Please charge immediately!\nAutomatic suspend triggers at 3%.", 
                "-u", "critical",
                "-a", "Shell"
            ]);
        }    
    }

    onShouldInitiateSuspendChanged: {
        if (hasBattery && shouldInitiateSuspend) {
            Quickshell.execDetached(["bash", "-c", `systemctl suspend || loginctl suspend`]);
        }
    }
}