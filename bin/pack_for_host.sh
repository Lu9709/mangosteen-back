# pack_for_host.sh 是将代码打包放到宿主机的目录
# 注意修改 oh-my-env 目录名为你的目录名
dir=oh-my-env

time=$(date +'%Y%m%d-%H%M%S')
# 声明时间
dist=tmp/mangosteen-$time.tar.gz
# 打包路径
current_dir=$(dirname $0)
# 当前文件
deploy_dir=/workspaces/$dir/mangosteen_deploy

yes | rm tmp/mangosteen-*.tar.gz; 
yes | rm $deploy_dir/mangosteen-*.tar.gz; 

tar --exclude="tmp/cache/*" -czv -f $dist *
# tmp/cache/*文件下的不打包 * 表示不包含.开头的文件
mkdir -p $deploy_dir
# 创建文件夹
cp $current_dir/../config/host.Dockerfile $deploy_dir/Dockerfile
cp $current_dir/set_up_host.sh $deploy_dir/
mv $dist $deploy_dir
echo $time > $deploy_dir/version
echo 'DONE!' 