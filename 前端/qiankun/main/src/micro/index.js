import { registerMicroApps, addGlobalUncaughtErrorHandler } from 'qiankun';
export { start } from 'qiankun'

registerMicroApps([
    {
        name: 'micro_p1',
        entry: '//localhost:9527',
        container: '#micro',
        activeRule: '/micro_p1'
    },
    {
        name: 'micro_p2',
        entry: '//localhost:9528',
        container: '#micro',
        activeRule: '/micro_p2'
    }
])

addGlobalUncaughtErrorHandler(err => {
    console.error(err)
    const { message } = err
    // 加载失败时提示
    if (message && message.includes('died in status LOADING_SOURCE_CODE')) {
        console.error('微应用加载失败，请检查应用是否可运行')
    }
})