import Brightness from "../backlight"

/**
 * Gets the current backlight level then assigns the proper icon
 * for that level.
 *
 * @returns {string} The brightness icon.
 */
export function getBrightnessIcon(brightness: Brightness): string {
    const value = brightness.screen

    if (value < 0.33) {
        return "󰃞"
    } else if (value < 0.66) {
        return "󰃝"
    } else {
        return "󰃠"
    }
}