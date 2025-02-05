import { bind } from "astal"
import Battery from "gi://AstalBattery"

export function BatteryLevel() {
    const battery = Battery.get_default()

    return <box className="Battery"
        visible={bind(battery, "isPresent")}>
        <icon icon={bind(battery, "batteryIconName")} />
        <label label={bind(battery, "percentage").as(p =>
            ` ${Math.floor(p * 100)}%`
        )}/>
    </box>
}