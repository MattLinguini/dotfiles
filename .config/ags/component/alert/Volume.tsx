import {bind, Variable} from "astal"
import { SliderAlertWindow } from "./SliderAlertWindow"
import Wp from "gi://AstalWp"
import { getVolumeIcon } from "../util/icon/volume"

/**
 * A component that displays a volume alert window.
 * 
 * The funciton binds to the current audio device's properties 
 * (volume`, and `mute`) and creates a derived variable to 
 * ensure that updates to volume or mute states trigger the alert.
 *
 * @returns {JSX.Element} The volume alert window component.
 */
export function VolumeAlert(): JSX.Element {
    const defaultSpeaker = Wp.get_default()!.audio.default_speaker

    const speakerVar = Variable.derive([
        bind(defaultSpeaker, "volume"),
        bind(defaultSpeaker, "mute")
    ], (volume, mute) => ({volume, mute })); // Ensure that when either volume or mute change, it updates the binding.

    return <SliderAlertWindow
        iconLabel={speakerVar(() => getVolumeIcon(defaultSpeaker))}
        label={"Volume"}
        sliderValue={speakerVar(() => defaultSpeaker.volume)}
        windowName={"volumeAlert"}
        alertTimeout={1_000}/>
}