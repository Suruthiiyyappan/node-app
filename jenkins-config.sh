app_tag=`git ls-remote https://github.com/Suruthiiyyappan/node-app HEAD | awk '{print $1}'`

docker_app="642000/nodejenkins:$app_tag"
docker build -t $docker_app .

docker login -u 642000 -p yourpassword 

docker push $docker_app

scp -i /var/lib/jenkins/dev.pem deploy.sh ec2-user@172.31.91.130:/tmp

ssh -i /var/lib/jenkins/dev.pem ec2-user@172.31.91.130 chmod +x /tmp/deploy.sh

ssh -i /var/lib/jenkins/dev.pem ec2-user@172.31.91.130 /tmp/deploy.sh $docker_app
