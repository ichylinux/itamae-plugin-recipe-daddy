include_recipe 'daddy::mysql::common'

case os_version
when /rhel-7\.(.*?)/, /rhel-8\.(.*?)/
  package 'mysql-community-server' do
    user 'root'
  end
else
  raise I18n.t('itamae.errors.unsupported_os_version', os_version: os_version)
end

service 'mysqld' do
  user 'root'
  action [:enable, :start]
end
