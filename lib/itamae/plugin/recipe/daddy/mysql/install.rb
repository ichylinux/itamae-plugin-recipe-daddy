require 'daddy/itamae'

case os_version
when /rhel-6\.(.*?)/
  package 'mysql' do
    user 'root'
  end

  package 'mysql-server' do
    user 'root'
  end

  template '/etc/my.cnf' do
    user 'root'
    owner 'root'
    group 'root'
    mode '644'
  end

  service 'mysqld' do
    user 'root'
    action [:enable, :start]
  end

when /rhel-7\.(.*?)/
  package 'mariadb' do
    user 'root'
  end

  package 'mariadb-server' do
    user 'root'
  end

  template '/etc/my.cnf.d/daddy.cnf' do
    user 'root'
    owner 'root'
    group 'root'
    mode '644'
  end

  service 'mariadb' do
    user 'root'
    action [:enable, :start]
  end

else
  raise I18n.t('itamae.errors.unsupported_os_version', os_version: os_version)
end
