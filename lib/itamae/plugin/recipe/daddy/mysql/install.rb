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
  template '/etc/yum.repos.d/mysql-community.repo' do
    user 'root'
    owner 'root'
    group 'root'
    mode '644'
  end

  template '/etc/pki/rpm-gpg/RPM-GPG-KEY-mysql' do
    user 'root'
    owner 'root'
    group 'root'
    mode '644'
  end

  execute 'yum clean all --enablerepo=mysql57-community' do
    user 'root'
    action :nothing
    subscribes :run, "template[/etc/yum.repos.d/mysql-community.repo]", :immediately
  end

  package 'mysql-community-server' do
    user 'root'
  end

  package 'mysql-community-devel' do
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
