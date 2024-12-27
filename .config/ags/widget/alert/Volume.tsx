import {bind, Variable} from "astal"
import { AlertWindow } from "./AlertWindow"
import Wp from "gi://AstalWp"
import { getVolumeIcon } from "../utils/icons/volume"

export function VolumeAlert() {
    const defaultSpeaker = Wp.get_default()!.audio.default_speaker

    const speakerVar = Variable.derive([
        bind(defaultSpeaker, "description"),
        bind(defaultSpeaker, "volume"),
        bind(defaultSpeaker, "mute")
    ], (volume, mute) => ({volume, mute })); // Ensure that when either volume and mute change, it updates the binding.

    return <AlertWindow
        iconLabel={speakerVar(() => getVolumeIcon(defaultSpeaker))}
        label={"Volume"}
        sliderValue={speakerVar(() => defaultSpeaker.volume)}
        windowName={"volumeAlert"}/>
}