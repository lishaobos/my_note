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

<img src="https://user-gold-cdn.xitu.io/2018/4/14/162c4b63c9152782?imageView2/0/w/1280/h/960/format/webp/ignore-error/1">

2.安装Generic Webhook Trigger Plugin插件（系统管理-插件管理-搜索Generic Webhook Trigger Plugin）如果可选插件列表为空，点击高级标签页，替换升级站点的URL为：http://mirror.xmission.com/jenkins/updates/update-center.json并且点击提交和立即获取。

3.添加触发器<br/>
第2步安装的触发器插件功能很强大，可以根据不同的触发参数触发不同的构建操作，此次是根据不同分支提交部署到不同服务器。在任务配置里勾选Generic Webhook Trigger，添加请求变量

<img src="https://user-gold-cdn.xitu.io/2018/4/14/162c4c36ea15b935?imageView2/0/w/1280/h/960/format/webp/ignore-error/1">

4.配置 git hook

URL格式为 http://<User ID>:<API Token>@<Jenkins IP地址>:端口/generic-webhook-trigger/invoke <br/>
userid和api token在jenkins的系统管理-管理用户-admin-设置里。




  
