#/bin/sh

echo "Install Docker CE"
yum update -y
yum install docker -y
service docker start
usermod -aG docker ec2-user
mv /tmp/docker /etc/sysconfig/docker
chmod 644 /etc/sysconfig/docker
service docker restart
