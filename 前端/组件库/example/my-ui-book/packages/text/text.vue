<template>
    <div :style="{ color: color }">
        <slot>
            文字
        </slot>
    </div>
</template>

<script>
export default {
    name: 'MyText',
    props: {
        color: {
            type: String,
            default: 'red'
        }
    }
}
</script>

<style>













</style>