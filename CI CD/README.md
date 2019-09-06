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


  
