---
Author: mikigo
---

# FTP服务搭建



## 安装

```shell
sudo apt install vsftpd
```

## 配置用户

添加用户组

```shell
sudo groupadd ftpgroup
```

配置 `FTP` 访问用户 `uos`

```shell
sudo useradd -g ftpgroup -M -s /bin/bash uos
```

配置 `FTP` 访问密码

```shell
sudo passwd uos
```

之后输入 2 次密码即可；

## 修改配置项

```shell
sudo vim /etc/vsftpd.conf
```

配置以下内容：

```shell
# 文件编码
utf8_filesystem=YES

# 开启匿名访问
anonymous_enable=YES

# 匿名用户无密码
no_anon_password=YES

# 限定匿名用户目录，路径可以自定义
anon_root=/home/$USER/ftp

# 可写
write_enable=YES

# 匿名上传
anon_upload_enable=YES

# 匿名可写文件夹
anon_mkdir_write_enable=YES

# 其他用户匿名可写
anon_other_write_enable=YES

# 匿名用户创建文件时所得到的初始权限
# 022 新建的目录权限为755，新建的文件权限为644
anon_umask=022

# 本地用户
chroot_local_user=YES

# 用户列表
chroot_list_enable=YES

# 用户列表文件
chroot_list_file=/etc/vsftpd.chroot_list

# 权限用户目录，路径可以自定义
local_root=/ftp/ftp
```

配置用户列表文件：

```shell
sudo vim /etc/vsftpd.chroot_list
```

写入

> uos

## 创建FTP目录

```shell
sudo mkdir -p /ftp/ftp # 权限访问目录
sudo mkdir -p /home/$USER/ftp # 匿名访问目录
```

修改目录权限

```shell
sudo chmod -R 777 /ftp/ftp
sudo chmod -R 777 /home/$USER/ftp
```

## 重启服务

```shell
sudo systemctl restart vsftpd.service
sudo systemctl status vsftpd.service
```

## 一键安装脚本

```shell
sudo apt update
sudo apt install vsftpd
echo "输入当前用户密码"
sudo groupadd ftpgroup &> /dev/null
read -p "输入ftp访问账号:" user
sudo useradd -g ftpgroup -M -s /bin/bash $user
echo "输入ftp访问密码"
sudo passwd $user

sudo sed -ri '/anonymous_enable/d' /etc/vsftpd.conf &> /dev/null
sudo sed -ri '/no_anon_password/d' /etc/vsftpd.conf &> /dev/null
sudo sed -ri '/write_enable/d' /etc/vsftpd.conf &> /dev/null
sudo sed -ri '/anon_upload_enable/d' /etc/vsftpd.conf &> /dev/null
sudo sed -ri '/anon_mkdir_write_enable/d' /etc/vsftpd.conf &> /dev/null
sudo sed -ri '/anon_umask/d' /etc/vsftpd.conf &> /dev/null
sudo sed -ri '/anon_root/d' /etc/vsftpd.conf &> /dev/null
#sudo sed -ri "/listen_ipv6/aanonymous_enable=YES\nno_anon_password=YES\nanon_root=/srv/ftp/\nwrite_enable=YES\nanon_upload_enable=YES\nanon_mkdir_write_enable=YES\nanon_other_write_enable=YES\nanon_umask=022" /etc/vsftpd.conf &> /dev/null
sudo sed -ri '/utf8_filesystem/cutf8_filesystem=YES' /etc/vsftpd.conf &> /dev/null
sudo sed -ri '$a\write_enable=YES\nchroot_local_user=YES' /etc/vsftpd.conf &> /dev/null
sudo mkdir -p /ftp/ftp/uploads
sudo usermod -d /ftp/ftp $user
sudo chown root:ftpgroup /ftp/ftp
sudo chmod 755 /ftp/ftp
sudo chown $user:ftpgroup /ftp/ftp/uploads
sudo chmod 755 /ftp/ftp/uploads
sudo systemctl restart vsftpd.service
```

