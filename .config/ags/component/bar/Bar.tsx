import { App, Astal, Gtk, Gdk }  from "astal/gtk4";
import { Variable } from "astal"
import { Workspaces, FocusedClient } from "./widget/Workspaces"
import { Clock } from "./widget/Clock"
import { BatteryLevel } from "./widget/Battery"
import { Wifi } from "./widget/Network"

export default function Bar(gdkmonitor: Gdk.Monitor) {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

    return <window
        visible
        cssClasses={["Bar"]}
        gdkmonitor={gdkmonitor}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        anchor={TOP | LEFT | RIGHT}
        application={App}>
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