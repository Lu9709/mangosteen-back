# setup_host.sh 是启动docker环境
DB_PASSWORD=123456
# 容器密码
container_name=mangosteen-prod-1
# 容器名称

version=$(cat mangosteen_deploy/version)
# 部署版本

echo 'docker build ...'
docker build mangosteen_deploy -t mangosteen:$version
if [ "$(docker ps -aq -f name=^mangosteen-prod-1$)" ]; then
  echo 'docker rm ...'
  docker rm -f $container_name
fi
echo 'docker run ...'
docker run -d -p 3000:3000 --network=network1 -e DB_PASSWORD=$DB_PASSWORD --name=$container_name mangosteen:$version
echo 'DONE!' 