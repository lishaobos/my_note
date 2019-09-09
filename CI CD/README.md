<p>
<h1 align='center'>记录前端自动化的实施</h1>    
</p>

## Jenkins是什么？
Jenkins是一个开源软件项目，是基于Java开发的一种持续集成工具，用于监控持续重复的工作，旨在提供一个开放易用的软件平台，使软件的持续集成变成可能。

## 实现功能
本地不同分支提交，自动触发不同 Jenkins 任务，自动部署到对应的服务器。

# 开始

## 安装 java 环境

1.rpm 包下载地址<br/>
https://www.oracle.com/java/technologies/jdk8-downloads.html
  
2.安装命令<br/>
rpm -ivh 包
  
3.看是否安装成功命令<br/>
java -version
  

## 安装 Jenkins 

1.下载 Java 的 war 包<br/>
https://www.oracle.com/java/technologies/jdk8-downloads.html

2.启动 Jenkins<br/>

```
# 8848是启动的端口号,nohup 加上连接断开 Jenkins 不会退出
nohup java -jar jenkins.war --ajp13Port=-1 --httpPort=8848 

# 8848是启动的端口号,连接断开 Jenkins 会退出
java -jar jenkins.war --ajp13Port=-1 --httpPort=8848 

# 默认启动 8080 端口，连接关闭 Jenkins 会退出
java -jar jenkins.war 
```

3.网页访问你的 IP + 启动端口<br/>

## Jenkins初始化
1.jenkins的默认端口是8080,启动成功后在浏览器打开。<br/>
2.进入后会让我们输管理员密码，打开网页上提示路径下的文件，复制密码粘贴输入即可。<br/>
3.然后会让安装需要的插件，此处选默认即可，等待安装完成。<br/>
4.创建一个管理员账户。<br/>
5.上面都完成后会看到这个界面。<br/>

<img src="https://user-gold-cdn.xitu.io/2018/4/14/162c486771d8309c?imageView2/0/w/1280/h/960/format/webp/ignore-error/1" >

## 创建任务

1.点击创建一个新任务

<img src="https://user-gold-cdn.xitu.io/2018/4/14/162c48a03fd6dfdd?imageView2/0/w/1280/h/960/format/webp/ignore-error/1" />

2.选择自由风格，随便起一个名字

<img src="https://user-gold-cdn.xitu.io/2018/4/14/162c48a7c39e576f?imageView2/0/w/1280/h/960/format/webp/ignore-error/1" />

## 实现 git hook

下面就实现 git 钩子的功能，实现本地只要触发 push，会发送请求到 Jenkins，Jenkins 开始工作

1.选择刚才创建的任务，选择配置中的源码配置，按下图配置

<img src="./img/1.png">

2.安装Generic Webhook Trigger Plugin插件（系统管理-插件管理-搜索Generic Webhook Trigger Plugin）如果可选插件列表为空，点击高级标签页，替换升级站点的URL为：http://mirror.xmission.com/jenkins/updates/update-center.json并且点击提交和立即获取。

3.添加触发器<br/>
第2步安装的触发器插件功能很强大，可以根据不同的触发参数触发不同的构建操作，此次是根据不同分支提交部署到不同服务器。在任务配置里勾选Generic Webhook Trigger，添加请求变量

<img src="./img/2.png">

<img src="./img/2-1.png">

4.配置 git hook

URL格式为 http://<User ID>:<API Token>@<Jenkins IP地址>:端口/generic-webhook-trigger/invoke <br/>
userid和api token在jenkins的系统管理-管理用户-admin-设置里。
  
<img src="./img/3.png">

<img src="./img/4.png">

5.测试 hook

<img src="https://user-gold-cdn.xitu.io/2018/4/14/162c4df2c9b49941?imageView2/0/w/1280/h/960/format/webp/ignore-error/1">

点击测试，如果配置是成功的，你的Jenkins左侧栏构建执行状态里将会出现一个任务。

<img src="https://user-gold-cdn.xitu.io/2018/4/15/162c4e3169a3c1f3?imageView2/0/w/1280/h/960/format/webp/ignore-error/1">

另外，你也可以试下本地提交代码，提交代码后，jenkins也会开始一个任务,目前我们没有配置任务开始后让它做什么，所以默认它只会在你提交新代码后，将新代码拉取到jenkins服务器上。到此为止，git钩子我们配置完成。

<img src="https://user-gold-cdn.xitu.io/2018/4/15/162c7630b81b74c9?imageslim">


## 实现自动化构建

git push触发钩子后，jenkins就要开始工作了，自动化的构建任务可以有很多种，比如说安装升级依赖包，单元测试，e2e测试，压缩静态资源，批量重命名等等，无论是npm script还是webpack，gulp之类的工作流，你之前在本地能做的，在这里同样可以做。

1.首先，和本地运行npm script一样，我们要想在jenkins里面执行npm命令，先要在jenkins里面配置node的环境，可以通过配置环境变量的方式引入node，也可以通过安装插件的方式，这里使用了插件的方式，安装一下nvm wrapper这个插件。<br/>

2.打开刚刚的jenkins任务，点击配置里面的构建环境，勾选这个，并指定一个node版本。<br/>

<img src="./img/5.png">

3.点击构建，把要执行的命令输进去，多个命令使用&&分开（切记最后一行不用 &&）。<br/>

<img src="./img/6.png">

4. 保存。<br/>

5. 此时本地修改一下代码push测试一下（也可以点击立即构建测试），点击本次触发的那个任务，选择控制台输出，将会看到Jenkins在云端执行的过程。<br/>

6. 如果执行成功，点击项目的工作空间，将会发现多了dist和node_modules两个文件夹。

<img src="./img/7.png">

## 实现自动化部署

自动化部署可能是我们最需要的功能了，公司就一台服务器，我们可以使用人工部署的方式，但是如果公司有100台服务器呢，人工部署就有些吃力了，而且一旦线上出了问题，回滚也很麻烦。所以这一节实现一下自动部署的功能。

1.首先，先在Jenkins上装一个插件Publish Over SSH，我们将通过这个工具实现服务器部署功能。<br/>

2.在要部署代码的服务器上创建一个文件夹用于接收Jenkins传过来的代码，我在服务器上建了一个testjenkins的文件夹。<br/>

3.Jenkins想要往服务器上部署代码必须登录服务器才可以，这里有两种登录验证方式，一种是ssh验证，一种是密码验证，就像你自己登录你的服务器，你可以使用ssh免密登录，也可以每次输密码登录，系统管理-系统设置里找到Publish over SSH这一项。<br/>

重点参数说明：

```
Passphrase：密码（key的密码，没设置就是空）
Path to key：key文件（私钥）的路径
Key：将私钥复制到这个框中(path to key和key写一个即可)

SSH Servers的配置：
SSH Server Name：标识的名字（随便你取什么）
Hostname：需要连接ssh的主机名或ip地址（建议ip）
Username：用户名
Remote Directory：远程目录（上面第二步建的testjenkins文件夹的路径）

高级配置：
Use password authentication, or use a different key：勾选这个可以使用密码登录，不想配ssh的可以用这个先试试
Passphrase / Password：密码登录模式的密码
Port：端口（默认22）
Timeout (ms)：超时时间（毫秒）默认300000
```

配置完成后，点击Test Configuration测试一下是否可以连接上，如果成功会返回success，失败会返回报错信息，根据报错信息改正即可。

<img src="./img/8.png" >

4. 接下来进入我们创建的任务，点击构建，增加2行代码，意思是将dist里面的东西打包成一个文件，因为我们要传输。

```
cd dist&&
tar -zcvf dist.tar.gz *
```

<img src="./img/9.png">

5. 点击构建后操作，增加构建后操作步骤，选择send build artificial over SSH， 参数说明：<br/>

```
Name:选择一个你配好的ssh服务器
Source files ：写你要传输的文件路径
Remove prefix ：要去掉的前缀，不写远程服务器的目录结构将和Source files写的一致
Remote directory ：写你要部署在远程服务器的那个目录地址下，不写就是SSH Servers配置里默认远程目录
Exec command ：传输完了要执行的命令，我这里执行了解压缩和解压缩完成后删除压缩包2个命令
```

<img src="./img/10.png">

6. 现在当我们在本地修改代码提交到对应分支，就会自动部署到服务器

## 实现提交后邮件提醒

以QQ邮箱举例，设置 => 账户

<img src="./img/11.png">

这里我们不用E-mail Notification，因为它的邮件服务功能太少，无法自定义邮件内容及自定义触发钩子，而且只能在异常情况下才能发邮件。我们使用Editable Email Notification这个。

<br/>
要是用别的厂家的邮箱服务就查下别的邮箱厂家smtp怎么配，用qq邮箱的除了user Name和password其他的和我写一样就行。另外password写的不是qq邮箱的密码，而是开启smtp服务后发短信获取的密码
<br/>

<img src="./img/12.png">

<img src="./img/13.png">

<img src="./img/14.png">

然后就可以收到邮件了，结束。
  
