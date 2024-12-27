/* Credit to https://github.com/JohnOberhauser for most of this */

import {App, Astal, Gtk} from "astal/gtk3"
import {Binding, GLib} from "astal"

/**
 * Creates an alert window with a slider specifically used notify the user
 * of changes to a system values with a range (ex. brightness, volume).
 * 
 * @param iconLabel Font icon to displayed.
 * @param label Short description of the slider element being changed.
 * @param sliderValue Value of the slider element.
 * @param windowName Name of the window (for Window Manager reference).
 * @param alertTimeout Time it takes for the alert to disappear (in milliseconds).
 * @returns {JSX.Element} A window component alerting the user to a state change.
 */
export function SliderAlertWindow(
    {
        iconLabel,
        label,
        sliderValue,
        windowName,
        alertTimeout
    }: {
        iconLabel: Binding<string>,
        label: string,
        sliderValue: Binding<number>,
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
            sliderValue.subscribe(() => {
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
            css={"padding: 18px 5px;"}>
            <label
                css={"margin-right: 15px;"}
                className="alertIcon"
                label={iconLabel}/>
            <box
                vertical={true}
                css={"margin-left: 10px;"}
                valign={Gtk.Align.CENTER}>
                <label
                    className="labelSmall"
                    label={label}
                    halign={Gtk.Align.START}/>
                <slider
                    css="padding-top: 2px;"
                    className="alertProgress"
                    hexpand={true}
                    value={sliderValue}/>
            </box>
        </box>
    </window>
}