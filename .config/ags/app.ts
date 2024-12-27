import { App } from "astal/gtk3"
import style from "./style/main.scss"
import { BrightnessAlert } from "./component/alert/Brightness"
import { VolumeAlert, MicrophoneAlert } from "./component/alert/Audio"
import Bar from "./component/bar/Bar"


App.start({
    css: style,
    main() {
        Bar()
        BrightnessAlert()
        VolumeAlert()
        MicrophoneAlert();
    },
})
