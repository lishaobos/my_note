import Vue from 'vue'

/** MyUI component common definition */
export declare class MyUIComponent extends Vue {
  /** Install component into Vue */
  static install (vue: typeof Vue): void
}

/** Component size definition for button, input, etc */
export type MyUIComponentSize = 'large' | 'medium' | 'small' | 'mini'

/** Horizontal alignment */
export type MyUIHorizontalAlignment = 'left' | 'center' | 'right'
