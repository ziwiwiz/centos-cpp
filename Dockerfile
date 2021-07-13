#Version 0.1
FROM centos:latest

MAINTAINER ziwiwiz "yinjiakai19950509@gmail.com"

#设置root用户为后续命令的执行者
USER root

# 换源
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' >/etc/timezone

### 常用软件包 ###
RUN yum update -y
RUN yum install -y binutils
RUN yum install -y gdb
RUN yum install -y gcc
RUN yum install -y gcc-c++
RUN yum install -y valgrind
RUN yum install -y tcpdump
RUN yum install -y tree
RUN yum install -y perf
RUN yum install -y dstat
RUN yum install -y lsof
RUN yum install -y telnet
RUN yum install -y sudo
RUN yum install -y net-tools
RUN yum install -y wget
RUN yum install -y initscripts
RUN yum install -y lrzsz
RUN yum install -y git
RUN yum install -y ncurses-devel

### Java8 ###
RUN yum install -y java-1.8.0-openjdk

### MySQL client ###
RUN yum install -y unixODBC-devel
# 下载地址 https://dev.mysql.com/downloads/connector/odbc/
COPY mysql-connector-odbc-8.0.17-1.el7.x86_64.rpm /tmp
RUN yum install -y /tmp/mysql-connector-odbc-8.0.17-1.el7.x86_64.rpm
RUN yum install -y libncurses*

### gcc-5.2 ###
COPY gcc-5.2.0.tar.gz /tmp
RUN tar -C /usr/local -xzf /tmp/gcc-5.2.0.tar.gz

# ssh服务器
RUN yum install -y openssh-server openssh-clients
RUN mkdir /var/run/sshd && \
    mkdir /root/.ssh
# 修改 root 的密码为 123456
RUN echo 'root:123456' | chpasswd
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN ssh-keygen -A
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
# RUN systemctl start sshd.service
RUN systemctl enable sshd.service

# 添加global
RUN wget -P /tmp  https://ftp.gnu.org/pub/gnu/global/global-6.6.6.tar.gz
RUN tar -C /tmp -xzf /tmp/global-6.6.6.tar.gz
RUN cd /tmp/global-6.6.6 \
    && ./configure \
    && make \
    && make install

# 添加字符集
RUN dnf install glibc-langpack-en -y

# 添加billdev用户
RUN useradd -rm -d /home/billdev -s /bin/bash -g root -G root -u 1001 billdev
RUN echo 'billdev:billdev' | chpasswd
RUN echo "billdev ALL=(ALL)NOPASSWD:ALL" >> /etc/sudoers
USER billdev
COPY bash_profile /tmp
RUN cat /tmp/bash_profile>>/home/billdev/.bash_profile

### 清理工作 ###
USER root
RUN yum clean all
RUN rm -rf /var/cache/yum
RUN rm -rf /tmp/*
RUN rm -f /var/log/wtmp /var/log/btmp

#对外暴露端口
ENTRYPOINT ["/usr/sbin/init"]
