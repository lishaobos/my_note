// 实现这个项目的构建任务
const del = require('del')
const bs = require('browser-sync').create()

const { src, dest, parallel, series, watch } = require('gulp')
const less = require('gulp-less')
const babel = require('gulp-babel')
const swig = require('gulp-swig')
const imagemin = require('gulp-imagemin')
const useref = require('gulp-useref')
const if_ = require('gulp-if')
const uglify = require('gulp-uglify')
const cleanCss = require('gulp-clean-css')
const htmlmin = require('gulp-htmlmin')

const output = 'dist'
const tmp = 'tmp'
const path = {
    css: 'src/assets/styles/*.less',
    js: 'src/assets/scripts/*.js',
    html: 'src/**.html',
    image: 'src/assets/images/**',
    font: 'src/assets/fonts/**',
    public: 'public/**'
}
const flow = (...args) => {
    const arg = args.shift()
    const fnc = typeof arg === 'function' ? arg : () => arg
    return args.reduce((cur, next) => next(cur), fnc())
}


const css = () => {
    return src(path.css, { base: 'src' })
        .pipe(less())
        .pipe(dest(tmp))
        .pipe(bs.reload({ stream: true }))
}

const js = () => {
    return src(path.js, { base: 'src' })
        .pipe(babel({
            presets: ['@babel/env']
        }))
        .pipe(dest(tmp))
        .pipe(bs.reload({ stream: true }))
}

const html = () => {
    return src(path.html, { base: 'src' })
        .pipe(swig({
            defaults: {
                cache: false
            }
        }))
        .pipe(dest(tmp))
        .pipe(bs.reload({ stream: true }))
}

const image = () => {
    return src(path.image, { base: 'src' })
        .pipe(imagemin())
        .pipe(dest(output))
}

const font = () => {
    return src(path.font, { base: 'src' })
        .pipe(imagemin())
        .pipe(dest(output))
}

const copyOther = () => src(path.public, { base: 'public' }).pipe(dest(output))

const useRef = basePath => {
    return src(`${basePath}/*.html`, { base: basePath })
        .pipe(useref({
            searchPath: ['tmp', 'public', 'src', 'dist', '.']
        }))
}

const refCompress = stream => {
    return stream
        .pipe(if_(/\.js$/, uglify()))
        .pipe(if_(/\.css$/, cleanCss()))
        .pipe(if_(/\.html$/, htmlmin({
            collapseWhitespace: true,
            minifyCSS: true,
            minifyJS: true
        })))
}

const refBuild = () => flow(tmp, useRef, refCompress).pipe(dest(output))

// 监听不需要编译的
const watchStatic = () => {
    const files = ['image', 'font', 'public']
    watch(files.map(key => path[key]), bs.reload)
}

// 监听需要编译的
const watchActive = () => {
    watch(path.css, css)
    watch(path.js, js)
    watch(path.html, html)
}

const watchEffct = () => {
    watchStatic()
    watchActive()
}

const bsInit = () => {

    watchEffct()

    bs.init({
        port: 9527,
        server: {
            baseDir: tmp,
            routes: {
                '/node_modules': 'node_modules'
            }
        }
    })
}

const clean = () => del([output, tmp])

const compile = parallel(css, js, html)

const serve = series(clean, compile, bsInit)

const build = series(clean, compile, parallel(refBuild, copyOther, image, font))

module.exports = {
    clean,
    serve,
    build
}