# host.Dockerfile给宿主机运行镜像的dockerfile，配置环境
FROM ruby:3.0.0

ENV RAILS_ENV production
# 设置环境生产环境
RUN mkdir /mangosteen
# 设置文件夹
RUN bundle config mirror.https://rubygems.org https://gems.ruby-china.com
# 设置国内镜像源
WORKDIR /mangosteen
# 设置工作目录
ADD mangosteen-*.tar.gz ./
# 解压缩包 mangosteen-*.tar.gz 到当前目录名 *表示随机值
RUN bundle config set --local without 'development test'
# 安装依赖（不安装development test环境的包）
RUN bundle install
ENTRYPOINT bundle exec puma
# 即当运行docker run 的时候在运行