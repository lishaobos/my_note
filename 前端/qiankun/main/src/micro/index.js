import { registerMicroApps, addGlobalUncaughtErrorHandler } from 'qiankun';
export { start } from 'qiankun'

registerMicroApps([
    // {
    //     name: 'micro_p1',
    //     entry: '//localhost:9527',
    //     // entry: '//1.14.65.92:9527',
    //     container: '#micro',
    //     activeRule: '/micro_p1'
    // },
    // {
    //     name: 'micro_p2',
    //     entry: '//1.14.65.92:9528',
    //     container: '#micro',
    //     activeRule: '/micro_p2'
    // },
    {
        name: 'micro_p3',
        entry: '//localhost:9529',
        container: '#micro',
        activeRule: '/micro_p3'
    },
    {
        name: 'micro_p4',
        entry: '//localhost:5173',
        container: '#micro',
        activeRule: '/micro_p4'
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