version = ENV['NGINX_RTMP_MODULE_VERSION'] || ItamaePluginRecipeDaddy::NGINX_RTMP_MODULE_VERSION

directory '/opt/nginx-rtmp-module' do
  user 'root'
  owner ENV['USER']
  group ENV['USER']
  mode '755'
end

git "/opt/nginx-rtmp-module/v#{version}" do
  repository 'https://github.com/arut/nginx-rtmp-module.git'
  revision "v#{version}"
end
