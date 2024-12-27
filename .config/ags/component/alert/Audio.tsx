import {bind, Variable} from "astal"
import { SliderAlertWindow } from "./util/SliderAlertWindow"
import { IconAlertWindow } from "./util/IconAlertWindow"
import Wp from "gi://AstalWp"
import { getMicrophoneIcon, getVolumeIcon } from "../util/icon/volume"

/**
 * Displays a volume alert window.
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
        bind (defaultSpeaker, "mute")
    ], (volume, mute) => ({volume, mute }));

    return <SliderAlertWindow
        iconLabel={speakerVar(() => getVolumeIcon(defaultSpeaker))}
        label={"Volume"}
        sliderValue={speakerVar(() => defaultSpeaker.volume)}
        windowName={"volumeAlert"}
        alertTimeout={1_000}/>
}

/**
 * Displays an alert window when the microphone is muted.
 * 
 * The function binds to the current audio device's property
 * (`mute`) and creates a derived variable to 
 * ensure that updates to the mute state triggers the alert.
 *
 * @returns {JSX.Element} The volume alert window component.
 */
export function MicrophoneAlert(): JSX.Element {
    const defaultMic = Wp.get_default()!.audio.default_microphone

    const microphoneVar = Variable.derive([
        bind(defaultMic, "mute")
    ]);

    return <IconAlertWindow
        iconLabel={microphoneVar(() => getMicrophoneIcon(defaultMic))}
        boolValue={microphoneVar(() => defaultMic.mute)}
        windowName={"micMuteAlert"}
        alertTimeout={1_000}/>
}