import { App } from "astal/gtk3"
import style from "./style/main.scss"
import { BrightnessAlert } from "./component/alert/Brightness"
import { VolumeAlert } from "./component/alert/Volume"
import Bar from "./component/bar/Bar"


App.start({
    css: style,
    main() {
        Bar()
        BrightnessAlert()
        VolumeAlert()
    },
})
