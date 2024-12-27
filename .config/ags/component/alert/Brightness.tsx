import {bind} from "astal"
import Brightness from "../util/backlight"
import { SliderAlertWindow } from "./util/SliderAlertWindow"
import { getBrightnessIcon } from "../util/icon/brightness"

/**
 * A component that displays a brightness alert window.
 * 
 * The funciton binds to the device backlight and displays
 * an alert whenever the value of the backlight changes.
 *
 * @returns {JSX.Element} The brightness alert window component.
 */
export function BrightnessAlert() : JSX.Element {
    const brightness = Brightness.get_default()
    
    return <SliderAlertWindow
        iconLabel={bind(brightness, "screen").as(() => {
            return getBrightnessIcon(brightness)
        })}
        label={"Brightness"}
        sliderValue={bind(brightness, "screen")}
        windowName={"brightnessAlert"}
        alertTimeout={1_000}/>
}