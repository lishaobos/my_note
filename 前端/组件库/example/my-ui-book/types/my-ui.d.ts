import Vue from 'vue'
import { MyButton } from './button'
import { MyText } from './text'
  
export function install (vue: typeof Vue): void

export class Button extends MyButton {}

export class Text extends MyText {}