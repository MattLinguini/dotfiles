import {bind, Variable} from "astal"
import Brightness from "../utils/brightness"
import { AlertWindow } from "./AlertWindow"
import { getBrightnessIcon } from "../utils/icons/brightness"

export function BrightnessAlert() {
    const brightness = Brightness.get_default()
    
    return <AlertWindow
        iconLabel={bind(brightness, "screen").as(() => {
            return getBrightnessIcon(brightness)
        })}
        label={"Brightness"}
        sliderValue={bind(brightness, "screen")}
        windowName={"brightnessAlert"}/>
}