import { App} from "astal/gtk4";
import style from "./style/main.scss"
import Bar from "./component/bar/Bar";

App.start({
    css: style,
    main() {
        App.get_monitors().map(Bar)
    },
})
