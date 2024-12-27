import {bind, Variable} from "astal"
import { AlertWindow } from "./AlertWindow"
import Wp from "gi://AstalWp"
import { getVolumeIcon } from "../utils/icons/volume"

export function VolumeAlert() {
    const defaultSpeaker = Wp.get_default()!.audio.default_speaker

    const speakerVar = Variable.derive([
        bind(defaultSpeaker, "description"),
        bind(defaultSpeaker, "volume"),
        bind(defaultSpeaker, "mute") // TODO: For some reason my system always thinks "mute" is true so this never gets toggled.
    ])

    return <AlertWindow
        iconLabel={speakerVar(() => getVolumeIcon(defaultSpeaker))}
        label="Volume"
        sliderValue={bind(defaultSpeaker, "volume")}
        windowName={"volumeAlert"}/>
}