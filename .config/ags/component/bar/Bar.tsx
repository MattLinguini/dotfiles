import {App, Astal, Gtk} from "astal/gtk3"
import { Workspaces } from "./widget/Workspaces"

export default function () {
    let iconCss = ""

    return <window
        css={`background: transparent;`}
        monitor={0}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        margin={5}
        anchor={Astal.WindowAnchor.TOP
            | Astal.WindowAnchor.LEFT
            | Astal.WindowAnchor.RIGHT}
        application={App}>
        <centerbox
            className="window"
            css={`
                padding: 2px;
                min-height: 40px;
            `}>
            <box halign={Gtk.Align.START}>
                <Workspaces vertical={false}/>
            </box>
            <box>
            </box>
            <box halign={Gtk.Align.END}>
            </box>
        </centerbox>
    </window>
}