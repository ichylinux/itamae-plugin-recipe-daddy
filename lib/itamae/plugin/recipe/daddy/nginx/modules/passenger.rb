version = ENV['PASSENGER_VERSION'] || ItamaePluginRecipeDaddy::PASSENGER_VERSION
nginx_version = ENV['NGINX_VERSION'] || ItamaePluginRecipeDaddy::NGINX_VERSION
  
gem_package 'passenger' do
  user 'root'
  version version
end

execute "rm -Rf /opt/nginx/nginx-#{nginx_version}" do
  user 'root'
  subscribes :run, 'gem_package[passenger]'
  action :nothing
end
