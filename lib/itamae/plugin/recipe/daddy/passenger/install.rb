server_name = ENV['WEB_SERVER_NAME'] || Daddy.config.web.server_name
app_env = ENV['APPLICATION_ENV'] || Daddy.config.application.env
app_root = ENV['APPLICATION_ROOT'] || Daddy.config.application.root

template "/etc/nginx/conf.d/servers/#{server_name}.conf" do
  source ::File.join(File.dirname(__FILE__), 'templates', '_passenger.conf.erb')
  user 'root'
  owner 'root'
  group 'root'
  mode '644'
  variables server_name: server_name,
            rails_env: app_env,
            rails_root: app_root
end

if app_root.start_with?("/home/#{ENV['USER']}/")
  directory "/home/#{ENV['USER']}" do
    user 'root'
    owner ENV['USER']
    group ENV['USER']
    mode '755'
  end
end
