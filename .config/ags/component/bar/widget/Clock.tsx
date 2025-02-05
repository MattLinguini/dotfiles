import { Variable, GLib } from "astal"

export function Clock() {
    const time = Variable<string>("").poll(1000, () =>
        GLib.DateTime.new_now_local().format("%I:%M %p")!)

    const date = Variable<string>("").poll(1000, () =>
        GLib.DateTime.new_now_local().format("%Y %b. %d - %H:%M")!)

    return <label
        className="Time"
        tooltipText={date()}
        onDestroy={() => time.drop()}
        label={time()}
    />
}