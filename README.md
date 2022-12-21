# nginx
基于oprenresty写的一键FLASK对接后端的NG部署脚本


写在后面如何创建SSH-KEY
# sshkey

ssh-keygen -t ed25519 -C "13405999037@139.com"
cat ~/.ssh/id_ed25519.pub
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519



官方文档
https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent