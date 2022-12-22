# nginx
基于oprenresty写的一键FLASK对接后端的NG部署脚本

chmod +x flask-nginx.sh \n
./flask-nginx.sh

| 功能     | 命令                                                                                |
| -------- | ----------------------------------------------------------------------------------- |
| 一键部署 | chmod +x flask-nginx.sh<br> ./flask-nginx.sh                                        |
| 测试     | /usr/local/openresty/nginx/sbin/nginx -t                                            |
| 启动     | /usr/local/openresty/nginx/sbin/nginx -c /usr/local/openresty/nginx/conf/nginx.conf |
| 重启     | /usr/local/openresty/nginx/sbin/nginx -s reload                                     |





# SSHKEY
写在后面如何创建SSH-KEY
```
ssh-keygen -t ed25519 -C "13405999037@139.com"
cat ~/.ssh/id_ed25519.pub
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```
# bug
```
找到这么一段代码：

CORE_INCS="$CORE_INCS $OPENSSL/.openssl/include"
CORE_DEPS="$CORE_DEPS $OPENSSL/.openssl/include/openssl/ssl.h"
CORE_LIBS="$CORE_LIBS $OPENSSL/.openssl/lib/libssl.a"
CORE_LIBS="$CORE_LIBS $OPENSSL/.openssl/lib/libcrypto.a"
修改成以下代码：

CORE_INCS="$CORE_INCS $OPENSSL/include"
CORE_DEPS="$CORE_DEPS $OPENSSL/include/openssl/ssl.h"
CORE_LIBS="$CORE_LIBS $OPENSSL/libssl.a"
CORE_LIBS="$CORE_LIBS $OPENSSL/libcrypto.a"

```


[官方文档SSH对接文档](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent "官方文档SSH对接文档")
