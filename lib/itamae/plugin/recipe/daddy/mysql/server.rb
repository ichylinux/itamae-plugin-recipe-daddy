include_recipe 'daddy::mysql::common'

service 'mysqld' do
  user 'root'
  action [:disable, :stop]
end

directory '/var/lib/mysql84' do
  user 'root'
end

case os_version
when /rhel-7\.(.*?)/, /rhel-8\.(.*?)/
  template '/etc/systemd/system/mysqld.service' do
    user 'root'
  end

  execute 'systemctl daemon-reload' do
    user 'root'
    subscribes :run, 'template[/etc/systemd/system/mysqld.service]', :immediately
    action :nothing
  end
else
  raise I18n.t('itamae.errors.unsupported_os_version', os_version: os_version)
end

service 'mysqld' do
  user 'root'
  action [:enable, :start]
end
