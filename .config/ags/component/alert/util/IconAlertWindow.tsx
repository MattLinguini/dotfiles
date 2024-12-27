/* Credit to https://github.com/JohnOberhauser for most of this */

import {App, Astal, Gtk} from "astal/gtk3"
import {Binding, GLib} from "astal"

/**
 * Creates an alert window with an icon specifically used notify the user
 * of changes to a system boolean values (ex. mic/speakers muted).
 * 
 * @param iconLabel Font icon to displayed.
 * @param boolValue Value of the boolean element to watch.
 * @param windowName Name of the window (for Window Manager reference).
 * @param alertTimeout Time it takes for the alert to disappear (in milliseconds).
 * @returns {JSX.Element} A window component alerting the user to a state change.
 */
export function IconAlertWindow(
    {
        iconLabel,
        boolValue,
        windowName,
        alertTimeout
    }: {
        iconLabel: Binding<string>,
        boolValue: Binding<boolean>,
        windowName: string,
        alertTimeout: number
    }
): JSX.Element {
    let windowVisibilityTimeout: GLib.Source | null = null

    return <window
        monitor={0}
        name={windowName}
        application={App}
        anchor={Astal.WindowAnchor.BOTTOM}
        exclusivity={Astal.Exclusivity.NORMAL}
        layer={Astal.Layer.OVERLAY}
        className="window"
        margin_bottom={100}
        visible={false}
        setup={(self) => {
            let canShow = false
            setTimeout(() => {
                canShow = true
            }, 3_000)
            boolValue.subscribe(() => {
                if (!canShow) {
                    return
                }
                if (windowVisibilityTimeout != null) {
                    windowVisibilityTimeout.destroy()
                }
                self.visible = true
                windowVisibilityTimeout = setTimeout(() => {
                    self.visible = false
                    windowVisibilityTimeout?.destroy()
                    windowVisibilityTimeout = null
                }, alertTimeout)
            })
        }}>
        <box
            halign={Gtk.Align.CENTER}
            className={"alertContainer"}>
            <label
                css={"margin-right: 20px; min-width: 60px"} // Center icon and ensure box is the same width.
                className={"alertIcon"}
                label={iconLabel}/>
        </box>
    </window>
}