include_recipe 'daddy::mysql::common'

case os_version
when /rhel-7\.(.*?)/, /rhel-8\.(.*?)/
  package 'mysql-community-server' do
    user 'root'
  end

  template '/etc/my.cnf.d/daddy.cnf' do
    user 'root'
    owner 'root'
    group 'root'
    mode '644'
  end

  service 'mysqld' do
    user 'root'
    action [:enable, :start]
  end

else
  raise I18n.t('itamae.errors.unsupported_os_version', os_version: os_version)
end
