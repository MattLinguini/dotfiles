import { App } from "astal/gtk3"
import style from "./scss/main.scss"
import Bar from "./widget/bar/Bar"
import { BrightnessAlert } from "./widget/alert/Brightness"

App.start({
    css: style,
    main() {
        BrightnessAlert()
    },
})
