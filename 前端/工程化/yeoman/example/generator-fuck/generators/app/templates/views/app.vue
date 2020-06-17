<template>
    <div>
        <%= name %> 页面
    </div>
</template>

<script>
export default {
    name: '<%= name %>'
}
</script>

<style lang="<%= cssLoader === 'sass' ? 'scss' : cssLoader %>">

    div {
        background-color: <%= color %>;
    }

</style>