# 在linux系统中,ssh是远程登录的默认工具,因为该工具的协议使用了RSA/DSA的加密算法.
# 该工具做linux系统的远程管理是非常安全的。 telnet,因为其不安全性,在linux系统中
# 被搁置使用了。
# 
# ssh有一套很有用的工具,其中的ssh-keygen可以用来生成 private和public密钥.将生成
# 的public密钥拷贝到远程机器后,可以使ssh到另外一台机器的登陆不用密码.具体方法如
# 下.
# 
# 1) 在本地机器中的~/.ssh/目录下执行下命令,
# 
# ssh-keygen -t dsa
# 
# 将生成两个文件,id_dsa和 id_dsa.pub.
# 
# 2) 将id_dsa.pub拷贝到远程机器,并且将id_dsa.pub的内容添加到
# ~/.ssh/authorized_keys中.
# 
# cat id_dsa.pub >>authorized_keys
# 
# 注意:目录.ssh和文件authorized_keys的权限必须是600.
# 
# 完成这些工作后,用户从本地机器到远程机器的登录就不用密码了.
# 
# 转载自： http://shutiao2008.javaeye.com/blog/315102

mkdir -p ~/.ssh
cd ~/.ssh/
ssh_keygen -t dsa
echo "copy id_dsa.pub to remote server."
echo "cat id_dsa.pub >>authorized_keys"
