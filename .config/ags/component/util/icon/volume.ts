import Wp from "gi://AstalWp"

/**
 * Gets the current volume level then assigns the proper icon
 * for that level.
 *
 * @returns {string} The volume icon.
 */
export function getVolumeIcon(device?: Wp.Endpoint): string {
    let volume = device?.volume
    let muted = device?.mute
    if (volume == null) return ""

    if (volume === 0 || muted) {
        return "󰝟"
    } else if (volume < 0.33) {
        return ""
    } else if (volume < 0.66) {
        return ""
    } else {
        return "󰕾"
    }
}

/**
 * Gets the mute state of the microphone then
 * assigns the proper icon.
 *
 * @returns {string} The microphone icon.
 */
export function getMicrophoneIcon(device?: Wp.Endpoint): string {
    let volume = device?.volume
    let muted = device?.mute

    if (volume === 0 || muted) {
        return " " // We love font awesome icons not being a consistant size
    } else {
        return ""
    }
}