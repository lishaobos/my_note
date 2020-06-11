const Generator = require('yeoman-generator')
const path = require('path')



module.exports = class extends Generator {

    async prompting() {
        this.answers = await this.prompt([
            {
                type: "input",
                name: "name",
                message: "Your project name",
                default: this.appname // Default to current folder name
            },
            {
                type: "list",
                name: "cssLoader",
                message: "请选择你的 css 预处理器",
                choices: ['less', 'sass'],
                default: 'sass' // Default to current folder name
            }
        ])
    }

    writing() {
        this.fs.copyTpl(
            this.templatePath(),
            this.destinationPath(),
            this.answers
        )
    }
}