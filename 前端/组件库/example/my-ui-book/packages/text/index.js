import text from './text.vue'

text.install = Vue => {
    Vue.component(text.name, text)
}

export default text