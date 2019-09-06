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
nohup java -jar jenkins.war --ajp13Port=-1 --httpPort=8848 # 8848是启动的端口号

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

  
