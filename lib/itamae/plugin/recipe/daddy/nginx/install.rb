require 'daddy/itamae'

version = ENV['NGINX_VERSION'] || ItamaePluginRecipeDaddy::NGINX_VERSION
rtmp_version = ENV['NGINX_RTMP_MODULE_VERSION'] || ItamaePluginRecipeDaddy::NGINX_RTMP_MODULE_VERSION
app_type = ENV['app_type'] || Daddy.config.app_.type

# install destination
%w{
  /opt/nginx
  /opt/nginx/shared
  /opt/nginx/shared/letsencrypt
  /opt/nginx/shared/logs
}.each do |name|
  directory name do
    user 'root'
    owner 'root'
    group 'root'
    mode '755'
  end
end

%w{
  /opt/nginx/cache
}.each do |name|
  directory name do
    user 'root'
    owner 'nobody'
    group 'root'
    mode '755'
  end
end

# nginx source
execute "download nginx-#{version}" do
  cwd '/var/daddy/tmp'
  command <<-EOF
    wget https://nginx.org/download/nginx-#{version}.tar.gz
  EOF
  not_if "echo #{::File.read(::File.join(::File.dirname(__FILE__), "nginx-#{version}_sha256sum.txt")).strip} | sha256sum -c"
end

# module sources
include_recipe 'modules/nginx-rtmp-module'
include_recipe 'modules/passenger'

# build
execute 'build nginx' do
  cwd '/var/daddy/tmp'
  command <<-EOF
    set -eu
    rm -Rf nginx-#{version}/
    tar zxf nginx-#{version}.tar.gz
    pushd nginx-#{version}
      sudo ./configure \
        --prefix=/opt/nginx/nginx-#{version} \
        --conf-path=/etc/nginx/nginx.conf \
        --pid-path=/run/nginx.pid \
        --with-http_ssl_module \
        --add-dynamic-module=/opt/nginx-rtmp-module/v#{rtmp_version} \
        --add-dynamic-module=$(passenger-config --nginx-addon-dir)
      sudo chown -R #{ENV['USER']}:#{ENV['USER']} ./
      make
      sudo make install
      sudo touch /opt/nginx/nginx-#{version}/INSTALLED
    popd
  EOF
  not_if "test -e /opt/nginx/nginx-#{version}/INSTALLED"
end

link 'current' do
  user 'root'
  cwd '/opt/nginx'
  to "nginx-#{version}"
  force true
end

template '/etc/nginx/nginx.conf' do
  user 'root'
  owner 'root'
  group 'root'
  mode '644'
end

%w{
  /etc/nginx/conf.d
  /var/run/passenger-instreg
}.each do |name|
  directory name do
    user 'root'
    owner 'root'
    group 'root'
    mode '755'
  end
end

template '/etc/tmpfiles.d/passenger.conf' do
  user 'root'
  owner 'root'
  group 'root'
  mode '644'
  variables path: '/var/run/passenger-instreg',
      owner: 'root', group: 'root', mode: '0755'
end

template '/etc/nginx/conf.d/default.conf' do
  user 'root'
  owner 'root'
  group 'root'
  mode '644'
end

directory '/etc/nginx/conf.d/servers' do
  user 'root'
  owner 'root'
  group 'root'
  mode '755'
end

if app_type
  include_recipe File.join(File.dirname(File.dirname(__FILE__)), app_type, 'install.rb')
end

unless ENV['DOCKER']
  template '/lib/systemd/system/nginx.service' do
    user 'root'
  end
  
  execute 'systemctl daemon-reload' do
    user 'root'
    subscribes :run, 'template[/lib/systemd/system/nginx.service]', :immediately
    action :nothing
  end
end
