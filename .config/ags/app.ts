import { App } from "astal/gtk3"
import style from "./style.scss"
import Bar from "./widget/bar/Bar"
import { BrightnessAlert } from "./widget/alert/Brightness"

App.start({
    css: style,
    main() {
        App.get_monitors().map(Bar)

        BrightnessAlert()
    },
})
