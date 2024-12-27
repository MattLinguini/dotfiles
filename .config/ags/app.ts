import { App } from "astal/gtk3"
import style from "./scss/main.scss"
import { BrightnessAlert } from "./widget/alert/Brightness"
import { VolumeAlert } from "./widget/alert/Volume"

App.start({
    css: style,
    main() {
        BrightnessAlert()
        VolumeAlert()
    },
})
