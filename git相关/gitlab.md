本文用于记录服务器上 gitlab 的搭建，以及遇到的坑点。

# 注：https://about.gitlab.com/install/ 安装根据官网步骤来就行了，可以不用看下面的安装步骤

## 安装步骤（下面记录基于 centOS7）
    1.安装依赖
    sudo yum install -y curl policycoreutils-python openssh-server
    sudo systemctl enable sshd
    sudo systemctl start sshd

    sudo firewall-cmd --permanent --add-service=http
    sudo systemctl reload firewalld

    2.邮件设置
    sudo yum install postfix
    sudo systemctl enable postfix
    sudo systemctl start postfix

    3.下载 gitlab 包
    curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.rpm.sh | sudo bash

    4.安装
    sudo EXTERNAL_URL="https://gitlab.example.com" yum install -y gitlab-ee
    # 注：这个 https://gitlab.example.com" 可以换成自己的 ip 例如：http://192.168.2.88:99 ，这个就会是你安装的默认地址

## 安装 gitlab 与已有的 nginx 冲突（gitlab 页面显示502）

    1.vim /etc/gitlab/gitlab.rb ##这个找不到 可以 find -name gitlab.rb 查找这个文件的地址

    2.然后加入或者修改
    external_url '域名:端口号'
    unicorn['port'] = 端口号
    # 注：url 的端口号要和 unicorn 的端口号不一致

    3.进入 nginx 配置文件
        1.cd /usr/local/nginx/conf
        2.vim nginx.conf
        3.加入下面的配置
        upstream gitlab {
            # 7.x 版本在此位置
            # server unix:/var/opt/gitlab/gitlab-rails/tmp/sockets/gitlab.socket;
            # 8.0 位置
            server unix://var/opt/gitlab/gitlab-rails/sockets/gitlab.socket;
        }

        server {
            listen    端口号;  #修改端口号（nginx需要访问的端口号和gitlab.rb中 external_url 端口号保持一致  ）
            server_name localhost;  
            server_tokens off;    # don't show the version number, a security best practice
            root /opt/gitlab/embedded/service/gitlab-rails/public;
            client_max_body_size 250m;
            #access_log  /var/log/gitlab/nginx/gitlab_access.log;
            #error_log  /var/log/gitlab/nginx/gitlab_error.log;
        location / {
            try_files $uri $uri/index.html $uri.html @gitlab;
        }

        location @gitlab {
            proxy_read_timeout 300; # Some requests take more than 30 seconds.
            proxy_connect_timeout 300; # Some requests take more than 30 seconds.
            proxy_redirect    off;
            proxy_set_header  X-Forwarded-Proto $scheme;
            proxy_set_header  Host              $http_host;
            proxy_set_header  X-Real-IP        $remote_addr;
            proxy_set_header  X-Forwarded-For  $proxy_add_x_forwarded_for;
            proxy_set_header  X-Frame-Options  SAMEORIGIN;
            proxy_pass   http://127.0.0.1:端口号; #和gitlab.rb中unicorn['port']  端口号保持一致
        }

        location ~ ^/(assets)/  {
            root /opt/gitlab/embedded/service/gitlab-rails/public;
            expires max;
            add_header Cache-Control public;
        }

        error_page 502 /502.html;

        }
    
    4.重启 nginx，重启 gitlab
        systemctl restart nginx.service #重启 nginx
        sudo gitlab-ctl reconfigure #重启配置文件
        gitlab-ctl restart #重启gitlab


## gitlab 常用命令
    gitlab-ctl start #启动
    gitlab-ctl stop  #停止
    gitlab-ctl restart  #重启
    gitlab-ctl tail #查看所有日志
    gitlab-ctl tail nginx/gitlab_acces.log #查看 nginx 访问日志
    gitlab-ctl tail  postgresql #查看 postgresql 日志
    # 注：不行就加 sudo

## gitlab 卸载
    1.gitlab-ctl stop #停止 gitlab
    2.rpm -e gitlab-ce #卸载 gitlab
    3.查看 gitlab 进程，然后杀掉第一个守护进程
    4.find / -name gitlab | xargs rm -rf #删除掉所有 gitlab 文件目录

## 遇到的坑
    1.有些命令启动不了得加 sudo
    2.给 nginx 添加配置，如果复制进去有换行符那些，nginx 会报错，不行就在里面手动敲一遍。
    3.kill 是杀不死 nginx 的进程的，因为 gitlab-ctl 守护进程会启动 nginx（gitlab-ctl stop nginx #这个命令可以杀死进程）






