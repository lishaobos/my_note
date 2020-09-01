import button from './packages/button'
import text from './packages/text'

const components = [
    button,
    text
]

const install = Vue => {
    for (const item of components) {
        Vue.component(item.name, item)
    }
}

export default {
    install,
    button,
    text
}