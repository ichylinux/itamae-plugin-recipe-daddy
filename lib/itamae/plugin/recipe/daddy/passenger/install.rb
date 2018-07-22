server_name = ENV['SERVER_NAME'] || Daddy.config.web.server_name
rails_env = ENV['RAILS_ENV'] || Daddy.config.rails_env? ? Daddy.config.rails_env : 'development'
rails_root = ENV['RAILS_ROOT'] || Daddy.config.rails_root? ? Daddy.config.rails_root : File.expand_path('.')

template "/etc/nginx/conf.d/servers/#{server_name}.conf" do
  source ::File.join(File.dirname(__FILE__), 'templates', '_passenger.conf.erb')
  user 'root'
  owner 'root'
  group 'root'
  mode '644'
  variables server_name: server_name, rails_env: rails_env, rails_root: rails_root
end

if rails_root.start_with?("/home/#{ENV['USER']}/")
  directory "/home/#{ENV['USER']}" do
    user 'root'
    owner ENV['USER']
    group ENV['USER']
    mode '755'
  end
end
