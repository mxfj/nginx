# @ https://openresty.org/cn/
yum install -y wget pcre-devel libssl-dev openssl openssl-devel gcc gcc-c++ curl tree make lrzsz
# 安装升级openssl版本
cd /opt
if [ ! -d "/usr/local/openssl" ]; then
    wget --no-check-certificate https://www.openssl.org/source/openssl-1.1.1s.tar.gz
    tar -zxvf openssl-1.1.1s.tar.gz 
    mkdir /usr/local/openssl
    mv openssl-1.1.1s /usr/local/openssl
fi

# 安装openresty版本
if [ ! -f "/opt/bash.sh" ]; then
    cat << EOT >/opt/bash.sh
    cd /usr/local/src
    curl -O  https://openresty.org/download/openresty-1.21.4.1.tar.gz
    tar -zxf openresty-1.21.4.1.tar.gz
    cd  /usr/local/src/openresty-1.21.4.1
    sed -i s/'OPENSSL\/openssl\/include'/'OPENSSL\/include'/g ./bundle/nginx-1.21.4/auto/lib/openssl/conf
    sed -i s/'OPENSSL\/.openssl\/include'/'OPENSSL\/include'/g ./bundle/nginx-1.21.4/auto/lib/openssl/conf
    sed -i s/'OPENSSL\/openssl\/lib'/'OPENSSL\/lib'/g ./bundle/nginx-1.21.4/auto/lib/openssl/conf
    sed -i s/'OPENSSL\/.openssl\/lib'/'OPENSSL\/lib'/g ./bundle/nginx-1.21.4/auto/lib/openssl/conf
    ./configure --prefix=/usr/local/openresty \
    --with-http_ssl_module \
    --with-http_flv_module \
    --with-http_stub_status_module \
    --with-http_gzip_static_module \
    --with-http_realip_module \
    --with-pcre \
    --with-stream \
    --with-openssl=/usr/local/openssl \
     --with-http_addition_module --with-http_flv_module --with-http_gzip_static_module --with-http_realip_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_dav_module --with-http_v2_module
    gmake &&  gmake install
EOT
    chmod +x /opt/bash.sh
    sh -x /opt/bash.sh 
fi

if [ ! -d "/usr/local/openresty/nginx/conf/vhost" ]; then
    mkdir /usr/local/openresty/nginx/conf/vhost
    sed -i "28i \   \ include\ vhost\/\*\.conf\;"  /usr/local/openresty/nginx/conf/nginx.conf
    /usr/local/openresty/bin/openresty -t     
    cat << EOT > /usr/local/openresty/nginx/conf/vhost/shoppingcard.online.conf
server{
        listen       80;
        server_name  shoppingcard.online;
        error_page   500 502 503 504  /50x.html;

        location / {
                proxy_pass      http://38.54.94.49:5000;
                proxy_redirect off;
                proxy_set_header   Host             \$host;
                proxy_set_header   X-Real-IP        \$remote_addr;
                proxy_set_header   X-Forwarded-For  \$proxy_add_x_forwarded_for;
                chunked_transfer_encoding       off;
        }

}
EOT
/usr/local/openresty/bin/openresty -t
 /usr/local/openresty/bin/openresty -c /usr/local/openresty/nginx/conf/nginx.conf