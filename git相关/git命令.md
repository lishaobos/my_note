
## git的安装和使用

```
1.网上下载 git，安装完成后右键菜单 git->git bash

2.进行配置
    1.git config --global user.name  'lishaobo'     (这个和 github 账号一样)
    1.git config --global user.email 'www.....com'  (这个是注册的邮箱)

3.配置密钥
    1.cd ~/.ssh (先看有没有ssh，也就是配置)
    2.ssh-keygen -t rsa -C '邮箱'  (创建ssh)
    3.cd ~/.ssh
    4.ls (先观看有那些文件夹)
    5.cat id_rsa.pub 
    6.手动赋值到 GitHub 设置里面的一个什么 key，填进去

3.如何操作
    1.随便创建一个文件夹 (例如：名字为 test)
    2.进入文件夹，输入 git init (这个目录可以变成git可以管理的仓库)
    3.上面命令执行之后目录下多了一个 .git的目录，里面的文件不要修改
    4.例如：在test文件夹下创建一个read.txt，内容为 111
    5.三步走
        1.git add read.txt 或者 git add
        2.git status (看我们的修改状态)
        3.git commit -m '内容' 引号里面写修改的注释
    6.git remote add origin git@github.com:lishaobos/qqq.git (添加远程仓库
    7.git push -u origin master (上面命令将本地的master分支推送到origin主机，同时指定origin为默认主机，后面就可以不加任何参数使用git push了)
      
4.一些常用的命令
    git diff read.txt (这个是看修改的具体内容)
    git log (可以看我们的修改日志)
    cat read.txt (看文件的内容)
    git reset--hard HEAD^ (恢复到上一个版本)
    git branch xx  (xx是我们创建的分支的分支名字)
    git branch  (这个是看我们所有的分支)
    git branch -r (查看远程分支)
    git checkout -b xx  (xx是分支名字，语句的mean创建加切换)
    git checkout master (选中主分支)
    git merge xx (先选中主分支，然后执行就是合并分支，xx为分支名字)
    git pull (拉取远程仓库，并且跟新本地)

5.关于远程分支
    1.git checkout -b dev 创建本地分支
    2.git push origin dev:dev 以 dev 分支拷贝，创建远程分支 dev
    3.git branch -d dev 删除本地 dev 分支，建议不要在当前分支删除自己，若要 -d 变成 -D
    4.git push origin -d dev 删除远程 dev 分支
    5.git reflog 同样作用于回复删除后后悔的分支
```

---

## 关于优雅的提交代码记录

### 合并本地多次 commit 为 1 次

- 1.git log //查看 commit 日志
- 2.git rebase -i 日志id //意思就是后面的几个 commit 全部合并到这个 commit 上面
- 3.suqash 意思是会合并到上一个 commit，pick 意思是执行这个 commit，操作完保存
- 4.把 This is a combination... 到 Plase enter... 之间的全部删除掉，然后可以在其中加入一些文字，文字就是 commit 的内容
- 5.git push

### git stash 的使用

- 1.有时候切换分支，会提醒要提交本地修改到本地仓库，但是又不想增加一个 commit 记录，所以执行  git stash save '暂存'
- 2.git stash list //查看暂存列表
- 3.git stash pop //恢复最新的暂存，并且删除掉暂存列表里面的记录

---

## 关于 tag 的使用

说明：记录一个稳定的版本，和之后的开发分割开来。

### 命令
```
1.git tag //查看所有 tag
2.git tag -l v1.* //查看v1开头的版本
3.git tag v1.0 //创建轻量级 tag，这样创建的tag没有附带其他信息
4.git tag -a v1.0 -m '描述信息' //添加有描述信息的 tag
5.git show v1.0 //查看 v1.0 版本的 tag 详细信息
6.git tag -d v1.0 //删除 v1.0 tag，这个是删除本地 tag
7.git push origin :refs/tags/v1.0 //删除远程tag，确定先执行了第 6 步
8.git push origin v1.0 //提交 v1.0 这个 tag
9.git push origin --tags //git push的时候，tag是不会上传到服务器的,只有这样才行，这个是提交所有 tag
10.git checkout -b v1.0 test //拉取 v1.0 这个 tag，并且创建到 test 分支，建议这样拉取 tag
10.给之前提交的记录添加 tag
    1.git log //查看提交日志
    2.git tag -a v666 id名称 -m 'tag 描述信息'
    3.git push origin v666 //提交 v666 tag  
11.如果要修改某个特定版本的 tag，先拉下来特定 tag，然后删除远程的 tag，把本地拉下来的代码 push ，tag 名字是原来的就行
```

---

## 对于 git 回滚到固定版本

```
1.git log //查看日志
2.git reset --hard 版本号
3.git push --force //强制提交到远程仓库
```

## 对于回退版本之后想返回新版本

```
1.git reflog //查看所有的操作日志
2.git reset 版本号 --hard
```

## 对于 git pull 和 git commit 的顺序

```
1.在远程和本地无冲突的情况(每个人开发自己的模块)：git pull -> git commit -> git push
2.在有冲突的情况(一个模块被多个人改变)：git commit -> git pull -> git push
```

首先应该理解git的原理。

```
git分为两个仓库，一个是本地的，一个是远程的。
git add .和git commit都是针对你的本地仓库。
git add做了什么，你可以简单理解是标记下那些文件要被提交到本地仓库。
git commit就是把你标记的文件提交到本地仓库
git pull是从远程仓库拉代码并merge到你的本地仓库，pull是两个命令的合（fetch和merge）
所以理论上pull在这两个之前之后都没什么问题，但是通常推荐先pull，我的习惯是
pull、add、commit
```

---

## 创建新的版本库

```
git clone git@47.92.203.251:lishaobo/welcomenetwork.git
cd welcomenetwork
touch README.md
git add README.md
git commit -m "add README"
git push -u origin master
```

## 已存在的文件夹

```
cd existing_folder
git init
git remote add origin git@47.92.203.251:lishaobo/welcomenetwork.git
git add .
git commit -m "Initial commit"
git push -u origin master
```

## 已存在的版本库

```
cd existing_repo
git remote rename origin old-origin
git remote add origin git@47.92.203.251:lishaobo/welcomenetwork.git
git push -u origin --all
git push -u origin --tags
```
