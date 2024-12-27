import {App, Astal, Gtk, Gdk} from "astal/gtk3"
import { Workspaces, FocusedClient } from "./widget/Workspaces"
import { Clock } from "./widget/Clock"
import { BatteryLevel } from "./widget/Battery"
import { Wifi } from "./widget/Network"

export function Bar () {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

    return <window
        className="Bar"
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        anchor={TOP | LEFT | RIGHT}>
        <centerbox>
            <box hexpand halign={Gtk.Align.START}>
                <Workspaces />
            </box>
            <box>
                <FocusedClient />
            </box>
            <box hexpand halign={Gtk.Align.END} >
                <Wifi />
                <BatteryLevel />
                <Clock />
            </box>
        </centerbox>
    </window>
}